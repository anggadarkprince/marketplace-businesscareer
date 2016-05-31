package sketchproject.modules.states
{
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.utilities.GameUtils;
	
	import starling.events.Event;
	
	public class IdleState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var counter:int;
		private var counterLimit:int;
		private var action:int;
		private var currentHour:int;
		private var lastHour:int;
		private var idleTaken:int;
		
		private var isDelayWandering:Boolean;
		private var idleWanderingLimit:int;
		private var idleWanderingTaken:int;

		public function IdleState(agent:Agent)
		{
			this.agent = agent;
			this.name = "idle";
			
			this.counter = 0;
			this.counterLimit = 50 + GameUtils.randomFor(50);
			this.action = 0;
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter idle transition execute");
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_stand"));
			agent.baseCharacter.loop = false;
			agent.baseCharacter.stop();
			
			currentHour = WorldManager.instance.map.hour;
			lastHour = currentHour;
			
			agent.baseCharacter.addEventListener(Event.COMPLETE, function(event:Event):void{
				GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_stand"));
			});
			
			isDelayWandering = false;
			idleWanderingLimit = 0;
			idleWanderingTaken = 0;
			for(var i:int = 0;i<agent.action.stackState.length;i++){
				if(agent.action.stackState[i] == agent.idleAction){
					if(i!=0){
						if(agent.action.stackState[i-1] == agent.wanderingAction && agent.isFlocking){
							isDelayWandering = true;
							idleWanderingLimit = 100 + GameUtils.randomFor(400);
						}
					}					
				}
			}
			
			if(!agent.isStress){
				idleTaken = lastHour + GameUtils.randomFor(4,true);
			}
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate idle transition execute");
			if(isDelayWandering){				
				if(idleWanderingTaken++ > idleWanderingLimit){					
					agent.action.checkState(agent.idleAction,true);
					if(agent.action.getCurrentState() == agent.wanderingAction){
						agent.action.getCurrentState().initialize();
					}
					idleWanderingTaken = 0;
				}
			}
			
			this.counter++;
			if(this.counter == counterLimit)
			{
				this.action = GameUtils.randomFor(10);
				if(action > 6)
				{
					agent.facing = (agent.facing == "right")?"left":"right";
					agent.flipFacing();
				}
				else if(action > 4)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_yup"));
					agent.baseCharacter.play();
				}
				else if(action > 2)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_tada"));
					agent.baseCharacter.play();
				}
				
				counter = 0;
			}
			
			currentHour = WorldManager.instance.map.hour;
			if(currentHour!=lastHour)
			{
				// calculate stress or health, higher determinant more minimum stress effect probability, every agent has equal chance each other
				if(agent.action.checkState(agent.studyingAction))
				{
					if(agent.stress < 10 && GameUtils.probability((10-agent.actionWill)/10)){
						agent.stress += GameUtils.randomFor(4, false);
					}
					if(agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.1))){
						agent.health -= GameUtils.randomFor(2, false);
					}
				}
				else if(agent.action.checkState(agent.tradingAction))
				{
					if(agent.stress < 10 && GameUtils.probability((10-agent.actionWill)/10)){
						agent.stress += GameUtils.randomFor(4, false);
					}
					if(agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.5))){
						agent.health -= GameUtils.randomFor(2, false);
					}
				}
				else if(agent.action.checkState(agent.workingAction))
				{
					if(agent.stress < 10  && GameUtils.probability((10-agent.actionWill)/10)){
						agent.stress += GameUtils.randomFor(5, false);
					}
					if(agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.3))){
						agent.health -= GameUtils.randomFor(3, false);
					}					
				}
				
				// limit health and stress
				if(agent.health>10){
					agent.health = 10;
				}
				if(agent.stress<0){
					agent.stress = 0;
				}
				
				
				// health idle, sick or healthy, in home or hospital your health rise up and stress is colling down
				if(agent.action.checkState(agent.homewardAction) || agent.targetDistrict == "Hospital")
				{
					agent.health += GameUtils.randomFor(5, false);
					if(agent.health>10){
						agent.health = 10;
					}	
					agent.stress -= GameUtils.randomFor(2, false);
					if(agent.health<2){
						agent.health = 2;
					}	
				}
				
				if((agent.action.checkState(agent.homewardAction) || agent.targetDistrict == "Hospital") && agent.isSick)
				{
					if(agent.health > (8+GameUtils.randomFor(2))){
						//trace(agent.agentId, agent.role,"stop in home or hospital because is not sick anymore");	
						agent.isSick = false;						
						agent.action.checkState(agent.idleAction,true);
						agent.action.checkState(agent.homewardAction,true);
						agent.targetDistrict = "";
					}
				}
				
				if((agent.action.checkState(agent.homewardAction) || agent.targetDistrict == "Hospital") && agent.isStress)
				{
					if(agent.stress < (2-GameUtils.randomFor(2))){
						//trace(agent.agentId, agent.role,"stop in home or hospital because is not stress anymore");	
						agent.isSick = false;						
						agent.action.checkState(agent.idleAction,true);
						agent.action.checkState(agent.homewardAction,true);
						agent.targetDistrict = "";
					}
				}
								
				
				// stress idle, stress or not playing make agent happy
				if(agent.action.checkState(agent.playingAction))
				{
					agent.emotion = GameUtils.randomFor(3) + 7;
					agent.stress -= GameUtils.randomFor(8, false);	
					if(agent.stress<0){
						agent.stress = 0;
					}
				}								
				
				// check if agent now is palaying and he/she is stress
				if(agent.action.checkState(agent.playingAction) && agent.isStress)
				{
					if(agent.stress < GameUtils.randomFor(2)){
						//trace(agent.agentId, agent.role,"stop playing not stress anymore");
						agent.isStress = false;
						agent.action.checkState(agent.idleAction,true);
						agent.action.checkState(agent.playingAction,true);
					}
				}
				
				// check if agent now is playing and he/she is play at will and meet a couple hour then boring
				if(agent.action.checkState(agent.playingAction) && currentHour == idleTaken && !agent.isStress){
					//trace(agent.agentId, agent.role,"stop playing because boring");
					agent.action.checkState(agent.idleAction,true);
					agent.action.checkState(agent.playingAction,true);
				}
				
				
				//trace(agent.agentId, agent.role, "agent stress",agent.stress,"agent health",agent.health);
				lastHour = currentHour;
			}			
			
		}
		
		public function destroy():void
		{
			agent.alpha = 1;
			//trace(agent.agentId+" : onExit idle transition execute");
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.IdleState";
		}
	}
}