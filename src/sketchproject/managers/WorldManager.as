package sketchproject.managers
{
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.modules.RuleTracer;
	import sketchproject.modules.states.HomewardState;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.GameUtils;
	
	public class WorldManager
	{
		public static var instance:WorldManager;
		
		public var map:Map;
		public var listAgents:Array;
		public var listShop:Array;
		
		private var agent:Agent;		
		private var agentGenerator:AgentGenerator;		
		private var ruleTracer:RuleTracer;
		private var delay:uint;
		
		private var generateProbability:Number;
		private var dx:Number;
		private var dy:Number;		
		
		private var change:int = 0;
		
		public function WorldManager(map:Map, isSimulation:Boolean)
		{
			WorldManager.instance = this;
			this.map = map;
			
			listAgents = new Array();
			listShop = new Array();
			
			agentGenerator = new AgentGenerator();
			
			if(isSimulation){				
				agentGenerator.generateAgent(listAgents, listShop, map);
				
				ruleTracer = new RuleTracer();
				//ruleTracer.initialize(listAgents, map);
			}
			else{
				//agentGenerator.generateFreeman(listAgents, 100, map);
			}
			/*
			listAgents[0].coordinate = new Point(7,10);
			listAgents[0].cartesian = WorldManager.instance.map.placeAgentLocation(listAgents[0].coordinate);
			listAgents[0].position = IsoHelper.twoDToIso(listAgents[0].cartesian);	
			
			listAgents[0].x = listAgents[0].position.x;
			listAgents[0].y = listAgents[0].position.y;
			listAgents[0].action.pushState(listAgents[0].findingAction);
			*/
			listAgents[0].role = Agent.ROLE_TRADER;
			//listAgents[1].role = Agent.ROLE_TRADER;
			//listAgents[2].role = Agent.ROLE_WORKER;

			//trace(listAgents[0].role,listAgents[1].role,listAgents[2].role);
			delay = 0;
		}
					
		
		public function update():void
		{			
			// loop through agent list
			for(var i:uint; i<listAgents.length; i++)
			{
				// put an agent into variable and parse as Agent class
				agent = listAgents[i] as Agent;
				
				// update agent action
				agent.update();
				
				// delay rule checker for optimizing, so execute every 40 frame
				if(delay++%40==0){
					
					/**
					 * nested rule for main task
					 * preMainTaskEvaluation function will check day, weather and accidental chance
					 */ 
					if(preMainTaskEvaluation(agent))
					{
						/** 
						 * if agent isGoingTask true then check world time meet agent schedule 
						 * normal time 6-7 for student, 7-8 for worker, 8-9 for trader
						 * normal time 13 for student end, 15 for worker end, 17 for trader end
						 */
						checkMainTaskStart(agent, map.hour, map.minute);
						checkMainTaskEnd(agent, map.hour, map.minute);					
					}
					else{
						holidayTriggered(agent,map.hour);
					}
					
					
					
					if(influenceEvaluation(agent,listAgents)){
						trace("do influence action");						
					}
					
					/**
					 * for all agent except freeman will return home at 22
					 */
					if(map.hour == 22){
						if(agent.role != Agent.ROLE_FREEMAN){
							agent.action.pushState(agent.homewardAction);
						}						
					}
					
					delay = 0;
				}
				
				/*
				trace(change);
				if(change++ == 1200)
				{
					trace("-------------vacation");
					//agent.action.popState();
					agent.action.pushState(agent.vacationAction);
					trace("------state "+agent.action.getCurrentState().toString());
				}
				else if(change++ == 4000)
				{
					trace("-------------pop vacation, back wandering");
					agent.action.popState();	
					trace("------state "+agent.action.getCurrentState().toString());
				}
				*/
			}
		}
		
		
		
		
		/**
		 * prepare global variable then we cut off some effort for creation and destruction
		 * boolean type for all status day, weather, and accidental
		 */
		private var day:Boolean;
		private var weather:Boolean;
		private var accidental:Boolean;
		public function preMainTaskEvaluation(agent:Agent):Boolean
		{
			/**
			 * if mainRoleDone variable return true that mean agent have been complete main task 
			 * or it has accident action so we set mark as done
			 * then pass through this function
			 */
			if(agent.mainRoleDone){
				return false;
			}
			/**
			 * else check isGoingTask variable, the value contain, is agent will complete main task
			 * if it not yet decide to pass through then check task evaluation
			 */
			else if(!agent.isGoingTask)
			{
				/**
				 * check parameter of agent what will agent decide move or don't move
				 * we need 3 variables, 
				 * 
				 * 1) first the day condition, is today normal, weekend, freeday or holiday
				 * 
				 * 2) second weather, game world have 10 weather ranges, from bad (disaster cold) to - good (warm) - to bad (disaster burn)
				 *    agent have big positive effect at good weather and negative effect at disaster weather (too hot or too cold)
				 * 
				 * 3) third final accidental, then we can say an agent have a good day and good weather, in real life some people 
				 *    have a random mood, then that agent, suddenly it won't do some activity that ussualy do, some propability agent do
				 *    weird or opposite action still needed so this parameter will handle it.
				 * 
				 * for each variable let other rule function procced then return as value to check
				 */
				trace("main task evaluation");
				/** agent check the day for evaluating next action */
				day = checkMainTaskDay(agent);
				
				/** agent check the weather is affect agent doing outdoor activity */
				weather = checkWeatherEffect(agent);
				
				/** let say day and weather is okay but we put chance agent doing opposite action */
				accidental = checkAccidentalAction(agent,0.1);
				
				/**
				 * an agent will do their task when all condition for three of parameters return true
				 * agent return this dan is okay, weather is okay, accidental reverse the value then set isGoingTask true
				 * so when time has come that agent push main task appropriate their role;
				 */
				if(day && weather && accidental){
					agent.isGoingTask = true;					
				}
				/**
				 * when one of parameters return false mark agent has done their main task
				 * or agent do not complete main task and stay at home until next action called
				 */
				else{
					agent.mainRoleDone = true;	
				}				
			}
			
			/**
			 * for next iteration that agent has checked before
			 * if isGoingTask is true and mainRoleDone is false so agent still on work or waiting for execute by time so return true
			 * if mainRoleDone is true and whatever isGoingTask false or true this function return false because in begin statement has checked
			 */			
			return true;
		}
		
		
		/**
		 * check main task by day
		 * normal day will give big chance doing main task for all agent
		 * weekend worker agent will give small chance for doing main task
		 * freeday will pass for student agent, and small chance for worker and trader
		 * holiday will give small chance for all agent type
		 */
		public function checkMainTaskDay(agent:Agent):Boolean
		{
			/**
			 * ----student---------------------------------------
			 * normally student will free on sunday or holiday, but some cases they still go to school for reasonable activity
			 * check today is freeday? or is holiday? for student
			 * then check is this agent keep go to school or they don't
			 */
			if((DayCounter.isFreeday() || DayCounter.isHoliday()) && agent.role == Agent.ROLE_STUDENT)
			{		
				/**
				 * the game give 3% probability of 100%
				 * if they meet this probability so agent keep going to school on sunday or holiday
				 */
				if(GameUtils.probability(0.03))
				{
					trace(Agent.ROLE_STUDENT,"agent go on holiday or freeday because day accidental probability");
					return true;
				}
				
				/**
				 * if the probability doesn't meet so like a normal condition
				 * student doesn't go to school and stay at home for a while
				 * 1) mark a status that agent is free to have other action
				 * 2) set time an agent have free time
				 * 3) call holiday evaluation to give agent an action 
				 * then return this function false for give sign today not good
				 */
				trace(Agent.ROLE_STUDENT,"agent doesn't go because today is freeday or holiday");
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(5) + 7;
				holidayEvaluation(agent);
				
				return false;
			}
			/**
			 * ----worker---------------------------------------
			 * normally worker will free on saturday and sunday, but some cases they still go to factory for reasonable activity
			 * check today is freeday? or is weekend? for worker
			 * then check is this agent keep go to factory or they don't
			 */
			else if((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_WORKER)
			{
				/**
				 * the game give 1% probability of 100%
				 * if they meet this probability so agent keep going to factory on sunday or saturday
				 */
				if(GameUtils.probability(0.01))
				{
					trace(Agent.ROLE_WORKER,"agent go on holiday or freeday because day accidental probability");
					return true;
				}
				
				/**
				 * if the probability doesn't meet so like a normal condition
				 * worker doesn't go to factory and stay at home for a while
				 * some variable set like trader or student proccess
				 * then return this function false for give sign today not good
				 */
				trace(Agent.ROLE_WORKER,"agent doesn't go because today is weekend or freeday");
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(5) + 7;
				holidayEvaluation(agent);
				
				return false;
			}
			
			
			/**
			 * ----trader---------------------------------------
			 * normally trader will free on saturday and sunday, but some cases they still go to business center for reasonable activity
			 * check today is freeday? or is weekend? for worker
			 * then check is this agent keep go to factory or they don't
			 */
			else if((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_TRADER)
			{
				/**
				 * the game give 50% probability of 100%
				 * that mean trader have big chance between trading or not because businessman have a flexible for time
				 * if they meet this probability so agent keep going to business center on sunday or saturday
				 */
				if(GameUtils.probability(0.5))
				{
					trace(Agent.ROLE_TRADER,"agent go on holiday because accidental probability in weekend or freeday");
					return true;
				}
				
				/**
				 * if the probability doesn't meet so like a normal condition
				 * worker doesn't go to factory and stay at home for a while
				 * some variable set like trader or student proccess
				 * then return this function false for give sign today is not good
				 */
				trace(Agent.ROLE_TRADER,"agent doesn't go because today is weekend or freeday");
				agent.isFree = true;
				agent.freeTime = GameUtils.randomFor(5) + 7;
				holidayEvaluation(agent);
				
				return false;
			}
			
			/**
			 * if today is not freeday, weekend, holiday for each agent
			 * then today is beautiful so return true to tell this agent ready for today
			 */
			trace(agent.role,"agent go on because it's normal day");				
			return true;
		}
		
		/**
		 * check main task by weather
		 * every agent has a actionWill variable that represent determinant agent to make effort when to do something
		 * the game combine weather effect by good-disaster and actionWill to make decision what will agent do
		 */
		public function checkWeatherEffect(agent:Agent):Boolean
		{
			/**
			 * get weather probability weight from weather data
			 * this value has ranges between 0-1, small number will has small effect than bigger weight number
			 * weather: Hurricane Storm(0.2),Heavy Rain(0.4),Rain(0.6),Cloudy(0.8),Clammy(1),Sunny(1),Overcast(0.8),Hot(0.6),Heat up(0.4),Scorching(0.2)
			 */
			generateProbability = Number(Data.weather[0][5]);
			
			/**
			 * from here we make actionWill agent become three groups
			 * > 7 is high then we will give 1 (agent has spirit to make effort)
			 * > 4 and <= 7 average then we will give approximately 0.7 (the most common people to make effort)
			 * <=4 low but we give 0.5 added to weather weight probability (lazy person to make effort)
			 */
			if(agent.actionWill > 7){
				generateProbability += 1;
			}
			else if(agent.actionWill > 4){
				generateProbability += 0.7;
			}
			else{
				generateProbability += 0.5;
			}
			
			/**
			 * sum of actionWill + probability will divide by two
			 * let say we have cloudy and common actionWill then
			 * (0.8 + 0.7) / 2 = 1.5/2 = 7.5 or 75% chance agent will doing main task
			 * we can make a conclusion, high probability get from good weather and spirit people type or
			 * today is the most good weather like clammy or sunny and common or lazy people or theirs in opposite value
			 */
			generateProbability = generateProbability / 2;
			
			if(GameUtils.probability(generateProbability))
			{
				/**
				 * but wait, is not done there, let say you have spirit to through the day
				 * however maybe you are not in good mood or act weird then you make opposite decision that you ussualy do
				 * let say its have small probaility, the game give 1% you have weird act chance
				 */
				if(GameUtils.probability(0.01))
				{
					trace(agent.role,"agent doesn't go because weather accidental but determinant reachable",Data.weather[0][2],generateProbability);
					return false;
				}
				/**
				 * if weather accidental probability doesn't meet then return true
				 */
				trace(agent.role,"agent go because weather determinant reachable",Data.weather[0][2],generateProbability);
				return true;
			}
			else{
				/**
				 * if weather probability by actionWill doesn't meet then code will execute bellow
				 * but this row should be make agent doesn't go because low spirit but maybe in real world
				 * people just make random move or whatever you have low spirit on a bad day keep do whatever ussualy do in normal condition
				 * so the game give 1% chance for low spirit agent to keep doing main task
				 */
				if(GameUtils.probability(0.01))
				{
					trace(agent.role,"agent go because weather accidental but determinant unreachable",Data.weather[0][2],generateProbability);
					return true;
				}
				
				/**
				 * if weather accidental probability doesn't meet then return false
				 */
				trace(agent.role,"agent doesn't go because weather determinant unreachable",Data.weather[0][2],generateProbability);
				return false;
			}			
		}
		
		/**
		 * accidental action is general function for every agent move when needed
		 * this rule give natural action for agent has human behavior and make simulation
		 * unpredictable but keep consistant
		 */
		public function checkAccidentalAction(agent:Agent, probability:Number):Boolean{
			if(GameUtils.probability(probability)){
				trace(agent.role,"agent has a accidental action",agent.actionWill);
				return false;
			}
			trace(agent.role,"agent haven't a accidental action",agent.actionWill);
			return true;
		}
		
		
		
		
		
		
		
		
		
		
				
		public function stressEvaluation(agent:Agent):Boolean{
			if(agent.stress>=8){
				return true;
			}
			return false;
		}
		
		public function healthEvaluation(agent:Agent):Boolean{
			if(agent.health<=2){
				return true;
			}
			return false;
		}
		
		private var sick:Boolean;
		private var frustrated:Boolean;
		public function postMainTaskEvaluation(agent:Agent):void
		{
			sick = healthEvaluation(agent);
			frustrated = stressEvaluation(agent);
			trace(agent.agentId, agent.role,"--status,sick=",sick,"frustrated=",frustrated);
			if(sick){
				trace(agent.agentId, agent.role,"---sick");
				agent.isSick = true;
				if(GameUtils.probability(0.3)){
					trace(agent.agentId, agent.role,"go home because sick");	
					agent.action.pushState(agent.homewardAction);
				}
				else{
					trace(agent.agentId, agent.role,"go hospital because sick", agent.health);	
					agent.targetDistrict = "Hospital";
					agent.action.pushState(agent.visitingAction);
				}						
			}
			
			if(frustrated){
				trace(agent.agentId, agent.role,"---frustrated");
				agent.isStress = true;
				if(GameUtils.probability(0.3)){
					trace(agent.agentId, agent.role,"go home because stress");	
					agent.action.pushState(agent.homewardAction);
				}
				else{
					trace(agent.agentId, agent.role,"go playing because stress", agent.stress);
					agent.action.pushState(agent.playingAction);
				}
			}
			
			if(!sick && !frustrated){
				if(GameUtils.probability(0.3)){
					trace(agent.agentId, agent.role,"go playing at will", agent.stress);
					agent.action.pushState(agent.playingAction);
				}
				else{
					trace(agent.agentId, agent.role,"go home at will");
					agent.action.pushState(agent.homewardAction);
				}	
			}
		}
		
		private var holidayPlan:int;
		public function holidayEvaluation(agent:Agent):void
		{
			holidayPlan = GameUtils.randomFor(100);
			agent.action.checkState(agent.idleAction, true);
			if(holidayPlan > 60){
				trace(agent.agentId, agent.role,"plan to vacation");
				agent.action.pushState(agent.vacationAction);
			}
			else if(holidayPlan > 40){
				trace(agent.agentId, agent.role,"plan to play");
				agent.action.pushState(agent.playingAction);
			}
			else{
				trace(agent.agentId, agent.role,"plan to homeward");
				agent.action.pushState(agent.homewardAction);
			}
		}
		
		public function holidayTriggered(agent:Agent, hour:int):void
		{
			if(hour == agent.freeTime && agent.isFree){
				holidayEvaluation(agent);
				agent.isFree = false;
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// rule set		
		public function checkMainTaskStart(agent:Agent, hour:int, minute:int):Boolean
		{
			//----student---------------------------------------
			if(hour == 6 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_STUDENT && !agent.action.checkState(agent.studyingAction))
			{
				trace(agent.agentId, Agent.ROLE_STUDENT,"start");	
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.studyingAction);
				return true;
			}				
			//----worker----------------------------------------
			else if(hour == 7 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_WORKER && !agent.action.checkState(agent.workingAction))
			{
				trace(agent.agentId, Agent.ROLE_WORKER,"start");
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.workingAction);
				return true;
			}				
			//----trader----------------------------------------
			else if(hour == 8 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_TRADER && !agent.action.checkState(agent.tradingAction))
			{
				trace(agent.agentId, Agent.ROLE_TRADER,"start");	
				agent.action.checkState(agent.idleAction, true);
				agent.action.pushState(agent.tradingAction);
				return true;
			}	
			return false;
		}
		
		public function checkMainTaskEnd(agent:Agent, hour:int, minute:int):Boolean
		{
			if(!agent.mainRoleDone && agent.isGoingTask)
			{
				//----student---------------------------------------
				if(hour == 13 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_STUDENT)
				{	
					agent.action.checkState(agent.idleAction, true);
					agent.action.checkState(agent.studyingAction, true);					
					postMainTaskEvaluation(agent);			
					return true;
				}
				//----worker---------------------------------------
				else if(hour == 15 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_WORKER)
				{
					agent.action.checkState(agent.idleAction, true);			
					agent.action.checkState(agent.workingAction, true);
					postMainTaskEvaluation(agent);
					return true;
				}
				//----trader---------------------------------------
				else if(hour == 17 && minute == GameUtils.randomFor(60) && agent.role == Agent.ROLE_TRADER)
				{
					agent.action.checkState(agent.idleAction, true);				
					agent.action.checkState(agent.tradingAction, true);
					postMainTaskEvaluation(agent);
					return true;
				}
			}
			return false;
		}
		
		
		
		public function checkEventStart(agent:Agent):Boolean
		{
			if(map.isEventExist && !agent.isGoingEvent)
			{
				for(var i:int = 0;i < Data.event.length; i++)
				{
					if(map.hour >= Data.event[i][2] && map.hour < Data.event[i][3])
					{
						generateProbability = 30 - (Math.abs(agent.education - Data.event[i][6][0]) + Math.abs(agent.art - Data.event[i][6][1]) + Math.abs(agent.athletic - Data.event[i][6][2]));
						if(GameUtils.randomFor(30) < generateProbability)
						{
							if(GameUtils.probability(0.01))
							{
								trace(agent.role,"agent doesn't go because 1% event accidental probability but match",generateProbability);
								return false;
							}
							trace(agent.role,"agent is going to event because match enough",generateProbability);
							agent.eventId = Data.event[i][0];
							agent.targetDistrict = Config.event[agent.eventId-1][2];
							agent.isGoingEvent = true;
							agent.action.pushState(agent.visitingAction);
							return true;
						}
						else
						{
							if(GameUtils.probability(0.01))
							{
								trace(agent.role,"agent go because 1% event accidental probability but unmatch enough",generateProbability);
								agent.eventId = Data.event[i][0];
								agent.targetDistrict = Config.event[agent.eventId-1][2];
								agent.isGoingEvent = true;
								agent.action.pushState(agent.visitingAction);
								return true;
							}
							trace(agent.role,"agent doesn't go because unmatch enough",generateProbability);
							return false;
						}
					}
				}
			}
			return false;
		}
		
		public function checkEventEnd(agent:Agent):Boolean
		{
			if(map.isEventExist && agent.isGoingEvent)
			{
				for(var i:int = 0;i < Data.event.length; i++)
				{
					if(agent.eventId == Data.event[i][0])
					{
						if(map.hour >= Data.event[i][3])
						{
							agent.action.checkState(agent.visitingAction, true);
							agent.isGoingEvent = false;
							agent.eventId = 0;							
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public function checkStressStatus(agent:Agent):Boolean
		{
			if(agent.stress >= 8)
			{
				if(GameUtils.probability(0.02))
				{
					trace(agent.agentId,"stress agent doesn't playing/vacation because 2% accidental probability");
					return false;
				}
				return true;
			}
			return false;
		}	
		
		public function checkHealthStatus(agent:Agent):Boolean
		{
			if(agent.health <= 2)
			{
				if(GameUtils.probability(0.02))
				{
					trace(agent.agentId,"health agent doesn't playing/vacation because 2% accidental probability");
					return false;
				}
				return true;
			}
			return false;
		}	
		
		public function influenceEvaluation(agent:Agent, listAgent:Array):Boolean
		{
			if(GameUtils.randomFor(100)<5){
				for (var j:int = 0; j < listAgent.length; j++)
				{
					if(agent.agentId != Agent(listAgent[j]).agentId)
					{
						dx = agent.x - Agent(listAgent[j]).x;
						dy = agent.y - Agent(listAgent[j]).y;
						
						if(GameUtils.getDistance(dx,dy) < 30)
						{
							trace(agent.agentId,"closed enough to influencing",Agent(listAgent[j]).agentId);
							// action probability
							if(GameUtils.probability(agent.actionWill*0.1))
							{
								trace(agent.agentId,"has motivate to influence");
								// recommendation
								if(GameUtils.probability(0.5))
								{
									trace(agent.agentId,"recommendation influence",Agent(listAgent[j]).agentId);
									return true;
								}
								// disqualification
								else{
									trace(agent.agentId,"disqualification influence",Agent(listAgent[j]).agentId);
									return true;
								}
							}
						}
					}				
				}
			}			
			return false;
		}
		
		public function checkStimultiPhase():void
		{
			
		}
		
		public function checkRecognitionPhase():void
		{
			
		}
		
		public function checkTensionPhase():void{
			
		}
		
		public function checkMotivationPhase():void
		{
			
		}
		
		public function checkEvaluationPhase():void
		{
			
		}
		
		public function checkHabitPhase():void
		{
			
		}
	}
}