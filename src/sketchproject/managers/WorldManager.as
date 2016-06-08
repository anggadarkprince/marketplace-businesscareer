package sketchproject.managers
{
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.modules.MatchingSystem;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.GameUtils;

	/**
	 * Game world controller.
	 *
	 * @author Angga
	 */
	public class WorldManager
	{
		public static var instance:WorldManager;

		public var map:Map;
		public var listAgent:Array;
		public var listShop:Array;

		private var agent:Agent;
		private var agentGenerator:AgentGenerator;
		private var ruleTracer:MatchingSystem;
		private var delay:uint;

		private var generateProbability:Number;
		private var dx:Number;
		private var dy:Number;

		/**
		 * Default constructor of WorldManager.
		 *
		 * @param map game world
		 * @param isSimulation status of simulation
		 */
		public function WorldManager(map:Map, isSimulation:Boolean)
		{
			WorldManager.instance = this;
			this.map = map;

			listAgent = new Array();
			listShop = new Array();

			agentGenerator = new AgentGenerator();

			if (isSimulation)
			{
				agentGenerator.generateAgent(listAgent, listShop, map);
			}
			else
			{
				agentGenerator.generateFreeman(listAgent, 300, map);
				agentGenerator.generateWeather(Data.valueWeather, map);
				agentGenerator.generateEvent(Data.valueEvent);
				agentGenerator.generateCompetitor(listShop, Data.valueCompetitor, map);
			}

			delay = 0;
		}

		/**
		 * Update all agents, perform rule checker and motivation function.
		 */
		public function update():void
		{
			// loop through agent list
			for (var i:uint; i < listAgent.length; i++)
			{
				// put an agent into variable and parse as Agent class
				agent = listAgent[i] as Agent;

				// update agent SFSM action
				agent.update();

				// delay rule checker for optimizing, so execute every 40 frame
				if (delay++ % 40 == 0)
				{
					/**
					 * rule to produce decision for do main task
					 * preMainTaskEvaluation function will check day, weather and accidental chance
					 */
					if (preMainTaskEvaluation(agent))
					{
						/**
						 * if agent variable isGoingTask is true then check world time if meets agent's schedule
						 * (start)  normal time 6-7 for student, 7-8 for worker, 8-9 for trader
						 * (finish) normal time 13 for student, 15 for worker, 17 for trader
						 */
						checkMainTaskStart(agent, map.hour, map.minute);
						checkMainTaskEnd(agent, map.hour, map.minute);
					}
					else
					{
						/**
						 * agent decide to take day off,
						 * try to generate play or vacation action.
						 */
						holidayTriggered(agent, map.hour);
					}

					/**
					 * check if events attract agent to attend.
					 */
					if (eventEvaluation(agent))
					{
						checkEventStart(agent);
						checkEventEnd(agent);
					}

					/**
					 * check if agent close enough to give influence
					 */
					if (influenceEvaluation(agent, listAgent))
					{
						if(agent.action.getCurrentState() != agent.influenceAction){
							agent.isInfluencing = true;
							agent.action.pushState(agent.influenceAction);
						}						
					}

					/**
					 * check if agent needs to eat something
					 */
					if (consumptionTime(agent, listShop))
					{
						// if agent is working something or influencing pop last state
						if (agent.action.getCurrentState() == agent.idleAction)
						{
							agent.action.popState();
						}
						if (agent.action.getCurrentState() == agent.influenceAction)
						{
							agent.action.popState();
						}
						agent.action.pushState(agent.eatingAction);
					}

					/**
					 * for all agent except freeman will return home at 22
					 */
					if (map.hour == 22)
					{
						if (agent.role != Agent.ROLE_FREEMAN)
						{
							agent.action.pushState(agent.homewardAction);
						}
					}

					delay = 0;
				}
			}
		}

		/**
		 * Check if time to eat.
		 *
		 * @param agent that need to buy something
		 * @param shopList collection of shop
		 * @return
		 */
		public function consumptionTime(agent:Agent, shopList:Array):Boolean
		{
			if (!agent.isEating && agent.consumption > 0)
			{
				if (agent.consumptionTime[agent.consumptionTime.length - agent.consumption].hour == map.hour)
				{
					if (agent.consumptionTime[agent.consumptionTime.length - agent.consumption].minute >= map.minute)
					{
						agent.isEating = true;
						agent.consumption--;
						return true;
					}
				}
			}
			return false;
		}

		/**
		 * prepare global variable to cut off some effort for creation and destruction
		 * boolean type for all statuses (day, weather, and accidental)
		 */
		private var day:Boolean;
		private var weather:Boolean;
		private var accidental:Boolean;

		/**
		 * Main Task evaluation based on agent's role and trait.
		 *
		 * @param agent to evaluation
		 * @return decision if agent will do main task or not
		 */
		public function preMainTaskEvaluation(agent:Agent):Boolean
		{
			/**
			 * if mainRoleDone variable id true that means agent have been completed the main task
			 * or it gets accident action so we set the variable true then pass this function
			 */
			if (agent.mainRoleDone)
			{
				return false;
			}
			/**
			 * otherwise check isGoingTask variable, check if agent doesn't decide going to
			 * complete the task through then check task evaluation
			 */
			else if (!agent.isGoingTask)
			{
				/**
				 * check parameter of agent what will agent decide move or don't move
				 * we need 3 variables,
				 *
				 * 1) first day condition, is today normal, weekend, freeday or holiday
				 *
				 * 2) second weather, game world have 10 weather ranges, from bad (disaster cold) to - good (warm) - to bad (disaster heat)
				 *    agent have big positive effect if good weather and negative effect if disaster weather (too hot or too cold)
				 *
				 * 3) third final accidental, then we can say an agent have a good day and good weather, in real life some people
				 *    have a random mood, then that agent, suddenly it won't do some activity that ussualy do, some propability agent do
				 *    weird or opposite action still needed so this parameter will handle it.
				 *
				 * for each variable let other rule function procced then return as value to check
				 */

				trace("- main task evaluation");

				/** agent check the day for evaluating next action */
				day = checkMainTaskDay(agent);

				/** agent check the weather is affect agent to outdoor activity */
				weather = checkWeatherEffect(agent);

				/** let's say variable day and weather is okay but we put agent to do opposite action by 10% chance */
				accidental = GameUtils.probability(0.9);

				/**
				 * agents will do their task when all condition for three of parameters return true
				 * so when time has come those agents push main task appropriate based on their role;
				 */
				if (day && weather && accidental)
				{
					agent.isGoingTask = true;
				}
				/**
				 * when one of the parameters return false set variable mainRoleDone to true
				 * agent do not complete main task and stay at home until next action triggered
				 */
				else
				{
					agent.mainRoleDone = true;
				}
			}

			/**
			 * for next iteration, agent who has been checked before
			 * if isGoingTask is true and mainRoleDone is false then agent still on work or waiting to executed by time so return true
			 * if mainRoleDone is true and whatever value of isGoingTask (false or true) this function return false because in begin of statements has checked
			 */
			return true;
		}


		/**
		 * check main task by day
		 * normal  : day will give big chance to doing main task for all agents
		 * weekend : worker agent will give small chance for doing main task
		 * freeday : will pass for student agent, and small chance for worker and trader
		 * holiday : will give small chance for all agent type
		 *
		 * @param agent that will to take evaluation
		 * @return status if agent will do action this day
		 */
		public function checkMainTaskDay(agent:Agent):Boolean
		{
			trace("  |-- day evaluation");

			/**
			 * ----student---------------------------------------
			 * normally student will free on sunday or holiday, but some cases they still go to school for reasonable activity
			 * check today is freeday? or is holiday? for student
			 * then check is this agent keep go to school or they don't
			 */

			if ((DayCounter.isFreeday() || DayCounter.isHoliday()) && agent.role == Agent.ROLE_STUDENT)
			{
				trace("    |--", Agent.ROLE_STUDENT);

				/**
				 * the game give 3% probability of 100%
				 * if they meet this probability so agent keep going to school on sunday or holiday
				 */
				if (GameUtils.probability(0.03))
				{
					trace("      |-- agent id", agent.agentId, "keep going on holiday or freeday because 3% accidental probability");
					return true;
				}

				trace("      |-- agent id", agent.agentId, "doesn't go because today is freeday or holiday");

				/**
				 * if the probability doesn't meet accidental so like normal condition
				 * student doesn't go to school and stay at home for a while
				 * 1) set a status that agent is free to have another action later
				 * 2) set time an agent have free time
				 * 3) call holiday evaluation to give agent an action
				 * then return this function false for give sign today not good
				 */
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(6) + 5;
				// holidayEvaluation(agent);

				return false;
			}
			/**
			 * ----worker---------------------------------------
			 * normally worker will free on saturday and sunday, but some cases they still go to factory for reasonable activity
			 * check today is freeday? or is weekend? for worker
			 * then check is this agent keep go to factory or they don't
			 */
			else if ((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_WORKER)
			{
				trace("    |--", Agent.ROLE_WORKER);

				/**
				 * game gives 1% probability of 100% to take accidental action
				 * if they meet this probability so agent keep going to factory on sunday or saturday
				 */
				if (GameUtils.probability(0.01))
				{
					trace("      |-- agent id", agent.agentId, "keep going on holiday or freeday because 1% accidental probability");
					return true;
				}

				trace("      |-- agent id", agent.agentId, "doesn't go because today is weekend or freeday");

				/**
				 * if the probability doesn't meet accidental so like a normal condition
				 * worker doesn't go to factory and stay at home for a while
				 * some variable set like trader or student proccess
				 * then return this function false for give sign today not good
				 */
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(5) + 5;
				// holidayEvaluation(agent);

				return false;
			}


			/**
			 * ----trader---------------------------------------
			 * normally trader will free on saturday and sunday, but some cases they still go to business center for reasonable activity
			 * check today is freeday? or is weekend? for trader
			 * then check is this agent keep go to factory or they don't
			 */
			else if ((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_TRADER)
			{
				trace("    |--", Agent.ROLE_TRADER);

				/**
				 * the game give 50% probability of 100%
				 * that mean trader have big chance between trading or not because businessman have a flexible for time
				 * if they meet this probability so agent keep going to business center on sunday or saturday
				 */
				if (GameUtils.probability(0.5))
				{
					trace("      |-- agent id", agent.agentId, "keep going on holiday because 50% probability");
					return true;
				}

				trace("      |-- agent id", agent.agentId, "doesn't go because today is weekend or freeday");

				/**
				 * if the probability doesn't meet so like a normal condition
				 * worker doesn't go to factory and stay at home for a while
				 * some variable set like trader or student proccess
				 * then return this function false for give sign today is not good
				 */
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(4) + 5;
				// holidayEvaluation(agent);

				return false;
			}

			/**
			 * if today is not freeday, weekend, holiday for each agent
			 * then today is beautiful :) so return true to tell agent ready to get work
			 */

			trace("    |-- agent id", agent.agentId, "keep going because it's normal day");

			return true;
		}

		/**
		 * check main task by weather
		 * every agent has a actionWill variable that represent determinant agent to make effort when to do something
		 * the game combine weather effect by good-disaster and actionWill to make decision what will agent do
		 *
		 * @param agent that will to take evaluation
		 * @return status of weather
		 */
		public function checkWeatherEffect(agent:Agent):Boolean
		{
			trace("  |-- weather evaluation");

			/**
			 * get weather probability weight from weather data
			 * this value has ranges between 0-1, small number will has small effect than bigger weight number
			 * weather: Hurricane Storm(0.2),Heavy Rain(0.4),Rain(0.6),Cloudy(0.8),Clammy(1),Sunny(1),Overcast(0.8),Hot(0.6),Heat up(0.4),Scorching(0.2)
			 */
			generateProbability = Number(Data.weather[0][5]);

			/**
			 * from here we break actionWill agent become three groups
			 * > 7 is high then we will give 1 (agent has spirit to make effort)
			 * > 4 and <= 7 average then we will give approximately 0.7 (the most common people to take action)
			 * <=4 low but we give 0.5 added to weather weight probability (lazy person to take action)
			 */
			if (agent.actionWill > 7)
			{
				generateProbability += 1;
			}
			else if (agent.actionWill > 4)
			{
				generateProbability += 0.7;
			}
			else
			{
				generateProbability += 0.5;
			}

			/**
			 * sum of actionWill + probability and divide by 2
			 * let's say we have cloudy weather and common actionWill 0,7 then
			 * (0.8 + 0.7) / 2 = 1.5/2 = 7.5 or 75% chance agent will doing main task
			 * we can make a conclusion, high probability get from good weather and determinant of agent
			 */
			generateProbability = generateProbability / 2;

			if (GameUtils.probability(generateProbability))
			{
				trace("    |-- weather passed, weather prob.", Data.weather[0][5] + "(" + Data.weather[0][2] + ")", "action will", generateProbability);

				/**
				 * but wait, it is not done yet, let's say you have spirit to through the day
				 * however maybe agents ain't in good mood or act weird then you make the opposite decision that you ussualy do
				 * let's say its has small probability, the game will gives 1% to invert agent act
				 */
				if (GameUtils.probability(0.01))
				{
					trace("      |-- agent id", agent.agentId, "doesn't go because weather accidental by 1%");
					return false;
				}

				/**
				 * if weather accidental probability doesn't meet the condition then return true
				 */

				trace("      |-- agent id", agent.agentId, "keep going because weather determinant reachable");

				return true;
			}
			/**
			 * sometime people is really lazzy to do something because of bad weather,
			 * then better to stay at home, but sometimes people is forced to do something important whatever condition outside
			 */
			else
			{
				trace("    |-- weather doesn't passed, weather prob.", Data.weather[0][2], "action will", generateProbability);

				/**
				 * if weather probability and actionWill doesn't meet the condition then code bellow will be executed
				 * actually now agent doesn't want to go because low determinant and bad weather but maybe in the real world
				 * people sometimes take random move on bad day to keep do whatever ussualy do in normal day and condition
				 * so the game will give 1% chance for lazzy agent to keep complete their main task
				 */
				if (GameUtils.probability(0.01))
				{
					trace("      |-- agent id", agent.agentId, "keep going because weather accidental by 1%");
					return true;
				}

				/**
				 * if weather accidental probability doesn't meet then return false
				 */

				trace("      |-- agent id", agent.agentId, "doesn't go because weather determinant unreachable");

				return false;
			}
		}

		/**
		 * Check if agent main task has triggered.
		 * normal time 6-7 for student, 7-8 for worker, 8-9 for trader
		 *
		 * @param agent that will to take evaluation
		 * @param hour current hour
		 * @param minute current minute
		 * @return status if task is started
		 */
		public function checkMainTaskStart(agent:Agent, hour:int, minute:int):Boolean
		{
			//----student---------------------------------------
			if (hour == 6 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_STUDENT && !agent.action.checkState(agent.studyingAction))
			{
				trace("        |-- agent id", agent.agentId, "start studying at school center");
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.studyingAction);
				return true;
			}
			//----worker----------------------------------------
			else if (hour == 7 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_WORKER && !agent.action.checkState(agent.workingAction))
			{
				trace("        |-- agent id", agent.agentId, "start working at factory district");
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.workingAction);
				return true;
			}
			//----trader----------------------------------------
			else if (hour == 8 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_TRADER && !agent.action.checkState(agent.tradingAction))
			{
				trace("        |-- agent id", agent.agentId, "start trading at business center district");
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.tradingAction);
				return true;
			}

			return false;
		}

		/**
		 * Check if agent main task has ended.
		 * normal time 13 for student, 15 for worker, 17 for trader
		 *
		 * @param agent that will to take evaluation
		 * @param hour current hour
		 * @param minute current minute
		 * @return status if task is started
		 */
		public function checkMainTaskEnd(agent:Agent, hour:int, minute:int):Boolean
		{
			if (!agent.mainRoleDone && agent.isGoingTask)
			{
				//----student---------------------------------------
				if (hour == 13 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_STUDENT)
				{
					trace("          |-- agent id ", agent.agentId, "completing main task as", Agent.ROLE_STUDENT);
					agent.action.checkState(agent.idleAction, true);
					agent.action.checkState(agent.studyingAction, true);
					postMainTaskEvaluation(agent);
					return true;
				}
				//----worker---------------------------------------
				else if (hour == 15 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_WORKER)
				{
					trace("          |-- agent id ", agent.agentId, "completing main task as", Agent.ROLE_WORKER);
					agent.action.checkState(agent.idleAction, true);
					agent.action.checkState(agent.workingAction, true);
					postMainTaskEvaluation(agent);
					return true;
				}
				//----trader---------------------------------------
				else if (hour == 17 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_TRADER)
				{
					trace("          |-- agent id ", agent.agentId, "completing main task as", Agent.ROLE_TRADER);
					agent.action.checkState(agent.idleAction, true);
					agent.action.checkState(agent.tradingAction, true);
					postMainTaskEvaluation(agent);
					return true;
				}
			}
			return false;
		}

		/**
		 * prepare global variable to cut off some effort for creation and destruction
		 * boolean type for mental statuses (sickness, frustated)
		 */
		private var sick:Boolean;
		private var frustrated:Boolean;

		/**
		 * Evaluating the next action after main task complete.
		 *
		 * @param agent that will to take evaluation
		 */
		public function postMainTaskEvaluation(agent:Agent):void
		{
			trace("          - post main task evaluation");
			sick = healthEvaluation(agent);
			frustrated = stressEvaluation(agent);

			if (sick)
			{
				agent.isSick = true;
				if (GameUtils.probability(0.5))
				{
					trace("                |-- [state:homeward] agent id", agent.agentId, "go to home because agent is unwell by 50% probability");
					agent.action.pushState(agent.homewardAction);
				}
				else
				{
					trace("                |-- [state:visiting] agent id", agent.agentId, "go to hospital because agent is unwell by 50% probability");
					agent.targetDistrict = "Hospital";
					agent.action.pushState(agent.visitingAction);
				}
			}

			if (frustrated)
			{
				agent.isStress = true;
				if (GameUtils.probability(0.3))
				{
					trace("                |-- [state:homeward] agent id", agent.agentId, "go to home because agent is frustrate by 30% probability");
					agent.action.pushState(agent.homewardAction);
				}
				else
				{
					trace("                |-- [state:playing] agent id", agent.agentId, "go to play because agent is frustrate by 70% probability");
					agent.action.pushState(agent.playingAction);
				}
			}

			if (!sick && !frustrated)
			{
				if (GameUtils.probability(0.3))
				{
					trace("                |-- [state:playing] agent id", agent.agentId, "go to play by 30% probability");
					agent.action.pushState(agent.playingAction);
				}
				else
				{
					trace("                |-- [state:homeward] agent id", agent.agentId, "go to play by 70% probability");
					agent.action.pushState(agent.homewardAction);
				}
			}
		}

		/**
		 * Agent in stress condition if stress value over than 7.
		 *
		 * @param agent that will to take evaluation
		 * @return status agent is stress or not
		 */
		public function stressEvaluation(agent:Agent):Boolean
		{
			trace("            |-- stress evaluation");
			if (agent.stress >= 8)
			{
				trace("              |-- agent id", agent.agentId, "is stress, current stress is ", agent.stress, "over than 7 (threshold)");
				return true;
			}
			trace("              |-- agent id", agent.agentId, "is not stress, current stress is ", agent.stress, "below 8 (threshold)");
			return false;
		}

		/**
		 * Agent in bad condition if health below 3.
		 *
		 * @param agent
		 * @return
		 */
		public function healthEvaluation(agent:Agent):Boolean
		{
			trace("            |-- health evaluation");
			if (agent.health <= 2)
			{
				trace("              |-- agent id", agent.agentId, "is sick, current HP is ", agent.health, "below 3 (threshold)");
				return true;
			}
			trace("              |-- agent id", agent.agentId, "is not sick, current HP is", agent.health, "over than 2 (threshold)");
			return false;
		}

		/**
		 *
		 * @param agent that will to take evaluation
		 * @param hour current hour
		 */
		public function holidayTriggered(agent:Agent, hour:int):void
		{
			if (hour == agent.freeTime && agent.isFree)
			{
				trace("  - day off evaluation");
				trace("    |-- agent id", agent.agentId, "has freetime at", agent.freeTime);
				holidayEvaluation(agent);
				agent.isFree = false;
			}
		}

		/**
		 * Check if agent need to refreshing or not.
		 *
		 * @param agent that will to take evaluation
		 */
		public function holidayEvaluation(agent:Agent):void
		{
			trace("      - holiday evaluation");

			var holidayPlan:int = GameUtils.randomFor(100);
			agent.action.checkState(agent.idleAction, true);
			if (holidayPlan > 60)
			{
				trace("        |-- agent id", agent.agentId, "plan to vacation by 60% probability");
				agent.action.pushState(agent.vacationAction);
			}
			else if (holidayPlan > 40)
			{
				trace("        |-- agent id", agent.agentId, "plan to vacation by 20% probability");
				agent.action.pushState(agent.playingAction);
			}
			else
			{
				trace("        |-- agent id", agent.agentId, "plan to stay at home by 20% probability");
				agent.action.pushState(agent.homewardAction);
			}
		}

		/**
		 * Evaluation all events if matched with agent trait.
		 *
		 * @param agent that will to take evaluation
		 */
		public function eventEvaluation(agent:Agent):Boolean
		{
			if (map.isEventExist && !agent.hasAttendingEventChecked && agent.role != Agent.ROLE_FREEMAN)
			{
				var hasEvaluated:Boolean = false;
				for (var i:int = 0; i < Data.event.length; i++)
				{
					for (var j:int = 0; i < agent.attendingEventList.length; i++)
					{
						if (agent.attendingEventList[j].eventId == Data.event[i][0])
						{
							hasEvaluated = true;
							break;
						}
					}
					if (!hasEvaluated)
					{
						trace("      - event evaluation", Data.event[i][1]);

						var isAttendingEvent:Boolean = false;

						var deltaEducation:Number = Math.abs(agent.education - Data.event[i][6][0]);
						var deltaArt:Number = Math.abs(agent.art - Data.event[i][6][1]);
						var deltaAthletic:Number = Math.abs(agent.athletic - Data.event[i][6][2]);
						generateProbability = 30 - (deltaEducation + deltaArt + deltaAthletic);

						if (GameUtils.randomFor(30) < generateProbability)
						{
							trace("        |-- event criteria match");
							if (GameUtils.probability(0.01))
							{
								trace("          |-- agent id", agent.agentId, "agent doesn't attend to event because 1% accidental probability");
								isAttendingEvent = false;
							}

							trace("          |-- agent id", agent.agentId, "agent attend to event");
							isAttendingEvent = true;
						}
						else
						{
							trace("        |-- event criteria doesn't match");
							if (GameUtils.probability(0.01))
							{
								trace("          |-- agent id", agent.agentId, "agent attend to event because 1% accidental probability");
								isAttendingEvent = true;
							}

							trace("          |-- agent id", agent.agentId, "agent doesn't attend to event");
							isAttendingEvent = false;
						}

						if (isAttendingEvent)
						{
							var extraTime:int = GameUtils.randomFor(2) - 1;
							if (GameUtils.probability(0.5))
							{
								extraTime = extraTime * -1;
							}
						}

						agent.attendingEventList.push({eventId: Data.event[i][0], eventName: Data.event[i][1], eventLocation: Data.event[i][7], eventStart: Data.event[i][2], eventFinish: int(Data.event[i][3]) + extraTime, eventAttending: isAttendingEvent});
					}
				}
				agent.hasAttendingEventChecked = true;
			}

			return agent.hasAttendingEventChecked;
		}

		/**
		 * Check event in game world get started.
		 *
		 * @param agent that will to take evaluation
		 * @return status if event has begun
		 */
		public function checkEventStart(agent:Agent):void
		{
			if (!agent.isGoingEvent)
			{
				for (var i:int = 0; i < Data.event.length; i++)
				{
					if (map.hour >= Data.event[i][2] && map.hour < Data.event[i][3])
					{
						for (var j:int = 0; j < agent.attendingEventList.length; j++)
						{
							if (Data.event[i][0] == agent.attendingEventList[j].eventId)
							{
								if (Boolean(agent.attendingEventList[j].eventAttending))
								{
									trace("            |-- agent id", agent.agentId, "now attending to event", agent.attendingEventList[j].eventName);
									agent.eventId = Data.event[i][0];
									agent.targetDistrict = Data.event[i][7];
									agent.isGoingEvent = true;
									agent.action.pushState(agent.visitingAction);
								}
								else
								{
									agent.attendingEventList.splice(j, 1);
								}
								break;
							}
						}
					}
				}
			}
		}

		/**
		 * Check if event is over.
		 *
		 * @param agent that will to take evaluation
		 * @return status if event has ended
		 */
		public function checkEventEnd(agent:Agent):void
		{
			if (agent.isGoingEvent)
			{
				for (var i:int = 0; i < Data.event.length; i++)
				{
					for (var j:int = 0; j < agent.attendingEventList.length; j++)
					{
						if (Data.event[i][0] == agent.attendingEventList[j].eventId)
						{
							if (map.hour >= agent.attendingEventList[j].eventFinish)
							{
								trace("          |-- agent id", agent.agentId, " agent leaves event", Data.event[i][1]);

								if (agent.action.getCurrentState() == agent.idleAction)
								{
									agent.action.checkState(agent.idleAction, true);
								}
								agent.action.checkState(agent.visitingAction, true);
								agent.isGoingEvent = false;
								agent.eventId = 0;
								agent.attendingEventList.splice(j, 1);
								break;
							}
						}
					}
				}
			}
		}

		/**
		 * Check if agent would gives recomendation or disqualification.
		 *
		 * @param agent that will to take evaluation
		 * @param listAgent all agent collection
		 * @return
		 */
		public function influenceEvaluation(agent:Agent, listAgent:Array):Boolean
		{
			if (agent.action.getCurrentState() != agent.idleAction && agent.action.getCurrentState() != agent.influenceAction && !agent.isInfluencing)
			{
				if (GameUtils.randomFor(100) == 10)
				{
					for (var j:int = 0; j < listAgent.length; j++)
					{
						if (agent.agentId != Agent(listAgent[j]).agentId)
						{
							dx = agent.x - Agent(listAgent[j]).x;
							dy = agent.y - Agent(listAgent[j]).y;

							if (GameUtils.getDistance(dx, dy) < 30)
							{
								trace("    - influence evaluation");
								trace("      |-- try to influencing people by 5% probability");
								trace("        |-- agent id", agent.agentId, "is close enough to influencing agent id", Agent(listAgent[j]).agentId);
								// influence probability
								if (GameUtils.probability(agent.actionWill * 0.1))
								{
									trace("          |-- agent id", agent.agentId, "has motivation to giving influence");
									giveInfluence(agent, listAgent[j]);

									return true;
								}
								else
								{
									trace("      |-- agent won't influence people");
								}
							}
						}
					}
				}
			}

			return false;
		}

		/**
		 * Giving influence to another agent.
		 *
		 * @param agent who gives influence
		 * @param target who receives the influence
		 * @param type of infulence, neither recommendation or disqualification
		 */
		public function giveInfluence(agent:Agent, target:Agent):void
		{
			if (agent.choice != 0 || agent.unselected != 0)
			{
				var recommendation:int;
				var disqualification:int;

				switch (agent.choice)
				{
					case 1:
						recommendation = int(target.shopInfluence.shopPlayer.recommendation);
						target.shopInfluence.shopPlayer.recommendation = recommendation + 1;
						break;
					case 2:
						recommendation = int(target.shopInfluence.shopCompetitor1.recommendation);
						target.shopInfluence.shopCompetitor1.recommendation = recommendation + 1;
						break;
					case 3:
						recommendation = int(target.shopInfluence.shopCompetitor2.recommendation);
						target.shopInfluence.shopCompetitor2.recommendation = recommendation + 1;
						break;
				}

				switch (agent.unselected)
				{
					case 1:
						disqualification = int(target.shopInfluence.shopPlayer.disqualification);
						target.shopInfluence.shopPlayer.disqualification = disqualification + 1;
						break;
					case 2:
						disqualification = int(target.shopInfluence.shopCompetitor1.disqualification);
						target.shopInfluence.shopCompetitor1.disqualification = disqualification + 1;
						break;
					case 3:
						disqualification = int(target.shopInfluence.shopCompetitor2.disqualification);
						target.shopInfluence.shopCompetitor2.disqualification = disqualification + 1;
						break;
				}
				trace("              |-- agent id", target.agentId, " as target : shop influence");
				trace("                |-- shop 1 (player) recommendation", target.shopInfluence.shopPlayer.recommendation, "disqualification", target.shopInfluence.shopPlayer.disqualification);
				trace("                |-- shop 2 (competitor 1) recommendation", target.shopInfluence.shopCompetitor1.recommendation, "disqualification", target.shopInfluence.shopCompetitor1.disqualification);
				trace("                |-- shop 3 (competitor 2) recommendation", target.shopInfluence.shopCompetitor2.recommendation, "disqualification", target.shopInfluence.shopCompetitor2.disqualification);
			}
			else
			{
				trace("              |-- agent id", target.agentId, " has nothing to recomended");
			}
		}
	}
}
