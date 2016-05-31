package sketchproject.objects.dialog
{
	import flash.geom.Point;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Shop setting dialog.
	 *
	 * @author Angga
	 */
	public class ShopDialog extends DialogOverlay
	{
		private var shopName:String;
		
		private var background:Image;
		private var bar:Quad;

		private var decorationModern:Quad;
		private var decorationColorfull:Quad;
		private var decorationVintage:Quad;

		private var cleanessProduct:Quad;
		private var cleanessPlace:Quad;

		private var scentGinger:Quad;
		private var scentJasmine:Quad;
		private var scentRosemary:Quad;

		private var adverTv:Quad;
		private var adverRadio:Quad;
		private var adverNews:Quad;
		private var adverInternet:Quad;
		private var adverEvent:Quad;
		private var adverBillboard:Quad;

		private var boosterShop:Quad;
		private var boosterProduct:Quad;
		private var boosterEmployee:Quad;
		private var boosterLucky:Quad;

		private var researchMarketing:Quad;
		private var researchServices:Quad;
		private var researchPointsale:Quad;
		private var researchProduct:Quad;
		private var researchFacility:Quad;

		private var incentiveReward:Quad;
		private var incentiveCareer:Quad;
		private var incentiveCultural:Quad;
		private var incentivePersonalization:Quad;
		private var incentiveManagement:Quad;

		private var benefitHealth:Quad;
		private var benefitEducation:Quad;
		private var benefitAdditional:Quad;
		private var benefitPolice:Quad;

		private var priceFood1:Quad;
		private var priceFood2:Quad;
		private var priceFood3:Quad;
		private var priceDrink1:Quad;
		private var priceDrink2:Quad;

		private var qualityFood1:Quad;
		private var qualityFood2:Quad;
		private var qualityFood3:Quad;
		private var qualityDrink1:Quad;
		private var qualityDrink2:Quad;

		private var employeeDianMorale:Quad;
		private var employeeFrandaMorale:Quad;
		private var employeeDavidMorale:Quad;
		private var employeeDhiniMorale:Quad;
		private var employeeChristianMorale:Quad;
		private var employeeRezaMorale:Quad;
		private var employeeVinoMorale:Quad;

		private var employeeDianServices:Quad;
		private var employeeFrandaServices:Quad;
		private var employeeDavidServices:Quad;
		private var employeeDhiniServices:Quad;
		private var employeeChristianServices:Quad;
		private var employeeRezaServices:Quad;
		private var employeeVinoServices:Quad;

		private var employeeDianProductivity:Quad;
		private var employeeFrandaProductivity:Quad;
		private var employeeDavidProductivity:Quad;
		private var employeeDhiniProductivity:Quad;
		private var employeeChristianProductivity:Quad;
		private var employeeRezaProductivity:Quad;
		private var employeeVinoProductivity:Quad;

		private var mouseLoc:Point;
		private var distance:int;
		private var step:Number = 10;
		private var stepPrice:Number = 2;
		private var stepQuality:Number = 5;

		/**
		 * Constructor of ShopDialog
		 */
		public function ShopDialog(name:String)
		{
			super();

			shopName = name;

			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogSetupShop"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			buttonClose.x = 381.8;
			buttonClose.y = 235.3;

			swapChildren(background, buttonClose);

			update();
		}

		/**
		 * Update bar width
		 */
		public function update():void
		{
			// add base of decoration bar
			for (var i:int = 0; i < Data.decoration.length; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = -322;
				bar.y = -146 + (i * 20);
				addChild(bar);
			}

			decorationModern = new Quad(10, 10, 0xFF7979);
			decorationModern.width = Math.ceil(Math.random() * 5) * 10;
			decorationModern.x = -322;
			decorationModern.y = -146;
			addChild(decorationModern);

			decorationColorfull = new Quad(10, 10, 0xFF7979);
			decorationColorfull.width = Math.ceil(Math.random() * 5) * 10;
			decorationColorfull.x = -322;
			decorationColorfull.y = -126;
			addChild(decorationColorfull);

			decorationVintage = new Quad(10, 10, 0xFF7979);
			decorationVintage.width = Math.ceil(Math.random() * 5) * 10;
			decorationVintage.x = -322;
			decorationVintage.y = -106;
			addChild(decorationVintage);

			// add base of cleanness bar
			for (i = 0; i < Data.cleanness.length; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = -322;
				bar.y = -60 + (i * 20);
				addChild(bar);
			}

			cleanessProduct = new Quad(10, 10, 0xFF7979);
			cleanessProduct.width = Math.ceil(Math.random() * 5) * 10;
			cleanessProduct.x = -322;
			cleanessProduct.y = -60;
			addChild(cleanessProduct);

			cleanessPlace = new Quad(10, 10, 0xFF7979);
			cleanessPlace.width = Math.ceil(Math.random() * 5) * 10;
			cleanessPlace.x = -322;
			cleanessPlace.y = -40;
			addChild(cleanessPlace);

			// add base of scent bar
			for (i = 0; i < Data.scent.length; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = -322;
				bar.y = 6 + (i * 20);
				addChild(bar);
			}

			scentGinger = new Quad(10, 10, 0xFF7979);
			scentGinger.width = Math.ceil(Math.random() * 5) * 10;
			scentGinger.x = -322;
			scentGinger.y = 6;
			addChild(scentGinger);

			scentJasmine = new Quad(10, 10, 0xFF7979);
			scentJasmine.width = Math.ceil(Math.random() * 5) * 10;
			scentJasmine.x = -322;
			scentJasmine.y = 26;
			addChild(scentJasmine);

			scentRosemary = new Quad(10, 10, 0xFF7979);
			scentRosemary.width = Math.ceil(Math.random() * 5) * 10;
			scentRosemary.x = -322;
			scentRosemary.y = 46;
			addChild(scentRosemary);

			// add base of booster bar
			for (i = 0; i < Data.booster.length; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = -322;
				bar.y = 123.95 + (i * 20);
				addChild(bar);
			}

			boosterShop = new Quad(10, 10, 0xFF7979);
			boosterShop.width = Math.ceil(Math.random() * 5) * 10;
			boosterShop.x = -322;
			boosterShop.y = 123.95;
			addChild(boosterShop);

			boosterProduct = new Quad(10, 10, 0xFF7979);
			boosterProduct.width = Math.ceil(Math.random() * 5) * 10;
			boosterProduct.x = -322;
			boosterProduct.y = 143.95;
			addChild(boosterProduct);

			boosterEmployee = new Quad(10, 10, 0xFF7979);
			boosterEmployee.width = Math.ceil(Math.random() * 5) * 10;
			boosterEmployee.x = -322;
			boosterEmployee.y = 163.95;
			addChild(boosterEmployee);

			boosterLucky = new Quad(10, 10, 0xFF7979);
			boosterLucky.width = Math.ceil(Math.random() * 5) * 10;
			boosterLucky.x = -322;
			boosterLucky.y = 183.95;
			addChild(boosterLucky);

			// add base of employee
			for (i = 0; i < 7; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = -63.1;
				bar.y = -141.05 + (i * 20);
				addChild(bar);

				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = 13.4;
				bar.y = -141.05 + (i * 20);
				addChild(bar);

				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = 89.9;
				bar.y = -141.05 + (i * 20);
				addChild(bar);
			}

			// employee morale
			employeeDianMorale = new Quad(10, 10, 0xFF7979);
			employeeDianMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeDianMorale.x = -63.1;
			employeeDianMorale.y = -141.05;
			addChild(employeeDianMorale);

			employeeFrandaMorale = new Quad(10, 10, 0xFF7979);
			employeeFrandaMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeFrandaMorale.x = -63.1;
			employeeFrandaMorale.y = -121.05;
			addChild(employeeFrandaMorale);

			employeeDavidMorale = new Quad(10, 10, 0xFF7979);
			employeeDavidMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeDavidMorale.x = -63.1;
			employeeDavidMorale.y = -101.05;
			addChild(employeeDavidMorale);

			employeeDhiniMorale = new Quad(10, 10, 0xFF7979);
			employeeDhiniMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeDhiniMorale.x = -63.1;
			employeeDhiniMorale.y = -81.05;
			addChild(employeeDhiniMorale);

			employeeChristianMorale = new Quad(10, 10, 0xFF7979);
			employeeChristianMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeChristianMorale.x = -63.1;
			employeeChristianMorale.y = -61.05;
			addChild(employeeChristianMorale);

			employeeRezaMorale = new Quad(10, 10, 0xFF7979);
			employeeRezaMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeRezaMorale.x = -63.1;
			employeeRezaMorale.y = -41.05;
			addChild(employeeRezaMorale);

			employeeVinoMorale = new Quad(10, 10, 0xFF7979);
			employeeVinoMorale.width = Math.ceil(Math.random() * 5) * 10;
			employeeVinoMorale.x = -63.1;
			employeeVinoMorale.y = -21.05;
			addChild(employeeVinoMorale);

			// employee service
			employeeDianServices = new Quad(10, 10, 0xFF7979);
			employeeDianServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeDianServices.x = 89.9;
			employeeDianServices.y = -141.05;
			addChild(employeeDianServices);

			employeeFrandaServices = new Quad(10, 10, 0xFF7979);
			employeeFrandaServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeFrandaServices.x = 89.9;
			employeeFrandaServices.y = -121.05;
			addChild(employeeFrandaServices);

			employeeDavidServices = new Quad(10, 10, 0xFF7979);
			employeeDavidServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeDavidServices.x = 89.9;
			employeeDavidServices.y = -101.05;
			addChild(employeeDavidServices);

			employeeDhiniServices = new Quad(10, 10, 0xFF7979);
			employeeDhiniServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeDhiniServices.x = 89.9;
			employeeDhiniServices.y = -81.05;
			addChild(employeeDhiniServices);

			employeeChristianServices = new Quad(10, 10, 0xFF7979);
			employeeChristianServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeChristianServices.x = 89.9;
			employeeChristianServices.y = -61.05;
			addChild(employeeChristianServices);

			employeeRezaServices = new Quad(10, 10, 0xFF7979);
			employeeRezaServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeRezaServices.x = 89.9;
			employeeRezaServices.y = -41.05;
			addChild(employeeRezaServices);

			employeeVinoServices = new Quad(10, 10, 0xFF7979);
			employeeVinoServices.width = Math.ceil(Math.random() * 5) * 10;
			employeeVinoServices.x = 89.9;
			employeeVinoServices.y = -21.05;
			addChild(employeeVinoServices);

			// employee productivity
			employeeDianProductivity = new Quad(10, 10, 0xFF7979);
			employeeDianProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeDianProductivity.x = 13.4;
			employeeDianProductivity.y = -141.05;
			addChild(employeeDianProductivity);

			employeeFrandaProductivity = new Quad(10, 10, 0xFF7979);
			employeeFrandaProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeFrandaProductivity.x = 13.4;
			employeeFrandaProductivity.y = -121.05;
			addChild(employeeFrandaProductivity);

			employeeDavidProductivity = new Quad(10, 10, 0xFF7979);
			employeeDavidProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeDavidProductivity.x = 13.4;
			employeeDavidProductivity.y = -101.05;
			addChild(employeeDavidProductivity);

			employeeDhiniProductivity = new Quad(10, 10, 0xFF7979);
			employeeDhiniProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeDhiniProductivity.x = 13.4;
			employeeDhiniProductivity.y = -81.05;
			addChild(employeeDhiniProductivity);

			employeeChristianProductivity = new Quad(10, 10, 0xFF7979);
			employeeChristianProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeChristianProductivity.x = 13.4;
			employeeChristianProductivity.y = -61.05;
			addChild(employeeChristianProductivity);

			employeeRezaProductivity = new Quad(10, 10, 0xFF7979);
			employeeRezaProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeRezaProductivity.x = 13.4;
			employeeRezaProductivity.y = -41.05;
			addChild(employeeRezaProductivity);

			employeeVinoProductivity = new Quad(10, 10, 0xFF7979);
			employeeVinoProductivity.width = Math.ceil(Math.random() * 5) * 10;
			employeeVinoProductivity.x = 13.4;
			employeeVinoProductivity.y = -21.05;
			addChild(employeeVinoProductivity);

			// research
			researchMarketing = new Quad(10, 10, 0xCCCCCC);
			researchMarketing.width = 10;
			researchMarketing.x = -210;
			researchMarketing.y = 86.2
			addChild(researchMarketing);

			researchServices = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			researchServices.width = 10;
			researchServices.x = -210;
			researchServices.y = 106.2
			addChild(researchServices);

			researchPointsale = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			researchPointsale.width = 10;
			researchPointsale.x = -210;
			researchPointsale.y = 126.2
			addChild(researchPointsale);

			researchProduct = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			researchProduct.width = 10;
			researchProduct.x = -210;
			researchProduct.y = 146.2
			addChild(researchProduct);

			researchFacility = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			researchFacility.width = 10;
			researchFacility.x = -210;
			researchFacility.y = 166.2
			addChild(researchFacility);

			// incentive
			incentiveReward = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			incentiveReward.width = 10;
			incentiveReward.x = -53.45;
			incentiveReward.y = 86.2;
			addChild(incentiveReward);

			incentiveCareer = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			incentiveCareer.width = 10;
			incentiveCareer.x = -53.45;
			incentiveCareer.y = 106.2;
			addChild(incentiveCareer);

			incentiveCultural = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			incentiveCultural.width = 10;
			incentiveCultural.x = -53.45;
			incentiveCultural.y = 126.2;
			addChild(incentiveCultural);

			incentivePersonalization = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			incentivePersonalization.width = 10;
			incentivePersonalization.x = -53.45;
			incentivePersonalization.y = 146.2;
			addChild(incentivePersonalization);

			incentiveManagement = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			incentiveManagement.width = 10;
			incentiveManagement.x = -53.45;
			incentiveManagement.y = 166.2;
			addChild(incentiveManagement);


			// benefit
			benefitHealth = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			benefitHealth.width = 10;
			benefitHealth.x = 120.95;
			benefitHealth.y = 86.2;
			addChild(benefitHealth);

			benefitEducation = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			benefitEducation.width = 10;
			benefitEducation.x = 120.95;
			benefitEducation.y = 106.2;
			addChild(benefitEducation);

			benefitAdditional = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			benefitAdditional.width = 10;
			benefitAdditional.x = 120.95;
			benefitAdditional.y = 126.2;
			addChild(benefitAdditional);

			benefitPolice = new Quad(10, 10, (Math.random() < 0.5) ? 0xCCCCCC : 0xFF7979);
			benefitPolice.width = 10;
			benefitPolice.x = 120.95;
			benefitPolice.y = 146.2;
			addChild(benefitPolice);

			// add base of product			
			for (i = 0; i < 5; i++)
			{
				// price
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = 287.5;
				if (i < 3)
				{
					bar.y = -143.55 + (i * 20);
				}
				else
				{
					bar.y = -40.85 + ((i - 3) * 20);
				}
				addChild(bar);

				// quality
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = 370.5;
				if (i < 3)
				{
					bar.y = -143.55 + (i * 20);
				}
				else
				{
					bar.y = -40.85 + ((i - 3) * 20);
				}
				addChild(bar);
			}

			// price
			priceFood1 = new Quad(10, 10, 0xFF7979);
			priceFood1.width = Math.ceil(Math.random() * 25) * 2;
			priceFood1.x = 287.5;
			priceFood1.y = -143.55;
			addChild(priceFood1);

			priceFood2 = new Quad(10, 10, 0xFF7979);
			priceFood2.width = Math.ceil(Math.random() * 25) * 2;
			priceFood2.x = 287.5;
			priceFood2.y = -123.55;
			addChild(priceFood2);

			priceFood3 = new Quad(10, 10, 0xFF7979);
			priceFood3.width = Math.ceil(Math.random() * 25) * 2;
			priceFood3.x = 287.5;
			priceFood3.y = -103.55;
			addChild(priceFood3);

			priceDrink1 = new Quad(10, 10, 0xFF7979);
			priceDrink1.width = Math.ceil(Math.random() * 25) * 2;
			priceDrink1.x = 287.5;
			priceDrink1.y = -40.85;
			addChild(priceDrink1);

			priceDrink2 = new Quad(10, 10, 0xFF7979);
			priceDrink2.width = Math.ceil(Math.random() * 25) * 2;
			priceDrink2.x = 287.5;
			priceDrink2.y = -20.85;
			addChild(priceDrink2);

			// quality
			qualityFood1 = new Quad(10, 10, 0xFF7979);
			qualityFood1.width = Math.ceil(Math.random() * 10) * 5;
			qualityFood1.x = 370.5;
			qualityFood1.y = -143.55;
			addChild(qualityFood1);

			qualityFood2 = new Quad(10, 10, 0xFF7979);
			qualityFood2.width = Math.ceil(Math.random() * 10) * 5;
			qualityFood2.x = 370.5;
			qualityFood2.y = -123.55;
			addChild(qualityFood2);

			qualityFood3 = new Quad(10, 10, 0xFF7979);
			qualityFood3.width = Math.ceil(Math.random() * 10) * 5;
			qualityFood3.x = 370.5;
			qualityFood3.y = -103.55;
			addChild(qualityFood3);

			qualityDrink1 = new Quad(10, 10, 0xFF7979);
			qualityDrink1.width = Math.ceil(Math.random() * 10) * 5;
			qualityDrink1.x = 370.5;
			qualityDrink1.y = -40.85
			addChild(qualityDrink1);

			qualityDrink2 = new Quad(10, 10, 0xFF7979);
			qualityDrink2.width = Math.ceil(Math.random() * 10) * 5;
			qualityDrink2.x = 370.5;
			qualityDrink2.y = -20.85
			addChild(qualityDrink2);

			// add base of adver
			for (i = 0; i < Data.advertising.length; i++)
			{
				bar = new Quad(10, 10, 0xCCCCCC);
				bar.width = 50;
				bar.x = 372.65;
				bar.y = 59.4 + (i * 20);
				addChild(bar);
			}

			adverTv = new Quad(10, 10, 0xFF7979);
			adverTv.width = Math.ceil(Math.random() * 5) * 10;
			adverTv.x = 372.65;
			adverTv.y = 59.4;
			addChild(adverTv);

			adverRadio = new Quad(10, 10, 0xFF7979);
			adverRadio.width = Math.ceil(Math.random() * 5) * 10;
			adverRadio.x = 372.65;
			adverRadio.y = 79.4;
			addChild(adverRadio);

			adverNews = new Quad(10, 10, 0xFF7979);
			adverNews.width = Math.ceil(Math.random() * 5) * 10;
			adverNews.x = 372.65;
			adverNews.y = 99.4;
			addChild(adverNews);

			adverInternet = new Quad(10, 10, 0xFF7979);
			adverInternet.width = Math.ceil(Math.random() * 5) * 10;
			adverInternet.x = 372.65;
			adverInternet.y = 119.4;
			addChild(adverInternet);

			adverEvent = new Quad(10, 10, 0xFF7979);
			adverEvent.width = Math.ceil(Math.random() * 5) * 10;
			adverEvent.x = 372.65;
			adverEvent.y = 139.4;
			addChild(adverEvent);

			adverBillboard = new Quad(10, 10, 0xFF7979);
			adverBillboard.width = Math.ceil(Math.random() * 5) * 10;
			adverBillboard.x = 372.65;
			adverBillboard.y = 159.4;
			addChild(adverBillboard);

			addEventListener(TouchEvent.TOUCH, onTouched);
		}

		/**
		 * Handle touch in this dialog.
		 *
		 * @param touch
		 */
		private function onTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(this) != null)
			{
				mouseLoc = touch.getTouch(this).getLocation(this);

				if (touch.getTouch(this).phase == TouchPhase.MOVED || touch.getTouch(this).phase == TouchPhase.ENDED)
				{
					// decoration
					if (mouseLoc.x >= decorationModern.x && mouseLoc.x <= (decorationModern.x + bar.width + step) && mouseLoc.y >= decorationModern.y && mouseLoc.y <= (decorationModern.y + decorationModern.height))
					{
						distance = Math.floor((mouseLoc.x - decorationModern.x) / step);
						decorationModern.width = distance * step;
					}

					if (mouseLoc.x >= decorationColorfull.x && mouseLoc.x <= (decorationColorfull.x + bar.width + step) && mouseLoc.y >= decorationColorfull.y && mouseLoc.y <= (decorationColorfull.y + decorationColorfull.height))
					{
						distance = Math.floor((mouseLoc.x - decorationColorfull.x) / step);
						decorationColorfull.width = distance * step;
					}

					if (mouseLoc.x >= decorationVintage.x && mouseLoc.x <= (decorationVintage.x + bar.width + step) && mouseLoc.y >= decorationVintage.y && mouseLoc.y <= (decorationVintage.y + decorationVintage.height))
					{
						distance = Math.floor((mouseLoc.x - decorationVintage.x) / step);
						decorationVintage.width = distance * step;
					}

					// cleaness
					if (mouseLoc.x >= cleanessProduct.x && mouseLoc.x <= (cleanessProduct.x + bar.width + step) && mouseLoc.y >= cleanessProduct.y && mouseLoc.y <= (cleanessProduct.y + cleanessProduct.height))
					{
						distance = Math.floor((mouseLoc.x - cleanessProduct.x) / step);
						cleanessProduct.width = distance * step;
					}

					if (mouseLoc.x >= cleanessPlace.x && mouseLoc.x <= (cleanessPlace.x + bar.width + step) && mouseLoc.y >= cleanessPlace.y && mouseLoc.y <= (cleanessPlace.y + cleanessPlace.height))
					{
						distance = Math.floor((mouseLoc.x - cleanessPlace.x) / step);
						cleanessPlace.width = distance * step;
					}

					// scent
					if (mouseLoc.x >= scentGinger.x && mouseLoc.x <= (scentGinger.x + bar.width + step) && mouseLoc.y >= scentGinger.y && mouseLoc.y <= (scentGinger.y + scentGinger.height))
					{
						distance = Math.floor((mouseLoc.x - scentGinger.x) / step);
						scentGinger.width = distance * step;
					}

					if (mouseLoc.x >= scentJasmine.x && mouseLoc.x <= (scentJasmine.x + bar.width + step) && mouseLoc.y >= scentJasmine.y && mouseLoc.y <= (scentJasmine.y + scentJasmine.height))
					{
						distance = Math.floor((mouseLoc.x - scentJasmine.x) / step);
						scentJasmine.width = distance * step;
					}

					if (mouseLoc.x >= scentRosemary.x && mouseLoc.x <= (scentRosemary.x + bar.width + step) && mouseLoc.y >= scentRosemary.y && mouseLoc.y <= (scentRosemary.y + scentRosemary.height))
					{
						distance = Math.floor((mouseLoc.x - scentRosemary.x) / step);
						scentRosemary.width = distance * step;
					}

					// booster
					if (mouseLoc.x >= boosterShop.x && mouseLoc.x <= (boosterShop.x + bar.width + step) && mouseLoc.y >= boosterShop.y && mouseLoc.y <= (boosterShop.y + boosterShop.height))
					{
						distance = Math.floor((mouseLoc.x - boosterShop.x) / step);
						boosterShop.width = distance * step;
					}

					if (mouseLoc.x >= boosterProduct.x && mouseLoc.x <= (boosterProduct.x + bar.width + step) && mouseLoc.y >= boosterProduct.y && mouseLoc.y <= (boosterProduct.y + boosterProduct.height))
					{
						distance = Math.floor((mouseLoc.x - boosterProduct.x) / step);
						boosterProduct.width = distance * step;
					}

					if (mouseLoc.x >= boosterEmployee.x && mouseLoc.x <= (boosterEmployee.x + bar.width + step) && mouseLoc.y >= boosterEmployee.y && mouseLoc.y <= (boosterEmployee.y + boosterEmployee.height))
					{
						distance = Math.floor((mouseLoc.x - boosterEmployee.x) / step);
						boosterEmployee.width = distance * step;
					}

					if (mouseLoc.x >= boosterLucky.x && mouseLoc.x <= (boosterLucky.x + bar.width + step) && mouseLoc.y >= boosterLucky.y && mouseLoc.y <= (boosterLucky.y + boosterLucky.height))
					{
						distance = Math.floor((mouseLoc.x - boosterLucky.x) / step);
						boosterLucky.width = distance * step;
					}

					// product
					if (mouseLoc.x >= priceFood1.x && mouseLoc.x <= (priceFood1.x + bar.width + stepPrice) && mouseLoc.y >= priceFood1.y && mouseLoc.y <= (priceFood1.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - priceFood1.x) / stepPrice);
						if (distance >= 3)
						{
							priceFood1.width = distance * stepPrice;
						}
					}

					if (mouseLoc.x >= priceFood2.x && mouseLoc.x <= (priceFood2.x + bar.width + stepPrice) && mouseLoc.y >= priceFood2.y && mouseLoc.y <= (priceFood2.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - priceFood2.x) / stepPrice);
						if (distance >= 3)
						{
							priceFood2.width = distance * stepPrice;
						}
					}

					if (mouseLoc.x >= priceFood3.x && mouseLoc.x <= (priceFood3.x + bar.width + stepPrice) && mouseLoc.y >= priceFood3.y && mouseLoc.y <= (priceFood3.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - priceFood3.x) / stepPrice);
						if (distance >= 3)
						{
							priceFood3.width = distance * stepPrice;
						}
					}

					if (mouseLoc.x >= priceDrink1.x && mouseLoc.x <= (priceDrink1.x + bar.width + stepPrice) && mouseLoc.y >= priceDrink1.y && mouseLoc.y <= (priceDrink1.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - priceDrink1.x) / stepPrice);
						if (distance >= 3)
						{
							priceDrink1.width = distance * stepPrice;
						}
					}

					if (mouseLoc.x >= priceDrink2.x && mouseLoc.x <= (priceDrink2.x + bar.width + stepPrice) && mouseLoc.y >= priceDrink2.y && mouseLoc.y <= (priceDrink2.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - priceDrink2.x) / stepPrice);
						if (distance >= 3)
						{
							priceDrink2.width = distance * stepPrice;
						}
					}


					// quality
					if (mouseLoc.x >= qualityFood1.x && mouseLoc.x <= (qualityFood1.x + bar.width + stepQuality) && mouseLoc.y >= qualityFood1.y && mouseLoc.y <= (qualityFood1.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - qualityFood1.x) / stepQuality);
						if (distance >= 1)
						{
							qualityFood1.width = distance * stepQuality;
						}
					}

					if (mouseLoc.x >= qualityFood2.x && mouseLoc.x <= (qualityFood2.x + bar.width + stepQuality) && mouseLoc.y >= qualityFood2.y && mouseLoc.y <= (qualityFood2.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - qualityFood2.x) / stepQuality);
						if (distance >= 1)
						{
							qualityFood2.width = distance * stepQuality;
						}
					}

					if (mouseLoc.x >= qualityFood3.x && mouseLoc.x <= (qualityFood3.x + bar.width + stepQuality) && mouseLoc.y >= qualityFood3.y && mouseLoc.y <= (qualityFood3.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - qualityFood3.x) / stepQuality);
						if (distance >= 1)
						{
							qualityFood3.width = distance * stepQuality;
						}
					}

					if (mouseLoc.x >= qualityDrink1.x && mouseLoc.x <= (qualityDrink1.x + bar.width + stepQuality) && mouseLoc.y >= qualityDrink1.y && mouseLoc.y <= (qualityDrink1.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - qualityDrink1.x) / stepQuality);
						if (distance >= 1)
						{
							qualityDrink1.width = distance * stepQuality;
						}
					}

					if (mouseLoc.x >= qualityDrink2.x && mouseLoc.x <= (qualityDrink2.x + bar.width + stepQuality) && mouseLoc.y >= qualityDrink2.y && mouseLoc.y <= (qualityDrink2.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - qualityDrink2.x) / stepQuality);
						if (distance >= 1)
						{
							qualityDrink2.width = distance * stepQuality;
						}
					}

					// employee
					if (mouseLoc.x >= employeeDianMorale.x && mouseLoc.x <= (employeeDianMorale.x + bar.width + step) && mouseLoc.y >= employeeDianMorale.y && mouseLoc.y <= (employeeDianMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDianMorale.x) / step);
						employeeDianMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeFrandaMorale.x && mouseLoc.x <= (employeeFrandaMorale.x + bar.width + step) && mouseLoc.y >= employeeFrandaMorale.y && mouseLoc.y <= (employeeFrandaMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaMorale.x) / step);
						employeeFrandaMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeDavidMorale.x && mouseLoc.x <= (employeeDavidMorale.x + bar.width + step) && mouseLoc.y >= employeeDavidMorale.y && mouseLoc.y <= (employeeDavidMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaMorale.x) / step);
						employeeDavidMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeDhiniMorale.x && mouseLoc.x <= (employeeDhiniMorale.x + bar.width + step) && mouseLoc.y >= employeeDhiniMorale.y && mouseLoc.y <= (employeeDhiniMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDhiniMorale.x) / step);
						employeeDhiniMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeChristianMorale.x && mouseLoc.x <= (employeeChristianMorale.x + bar.width + step) && mouseLoc.y >= employeeChristianMorale.y && mouseLoc.y <= (employeeChristianMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeChristianMorale.x) / step);
						employeeChristianMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeRezaMorale.x && mouseLoc.x <= (employeeRezaMorale.x + bar.width + step) && mouseLoc.y >= employeeRezaMorale.y && mouseLoc.y <= (employeeRezaMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeRezaMorale.x) / step);
						employeeRezaMorale.width = distance * step;
					}
					if (mouseLoc.x >= employeeVinoMorale.x && mouseLoc.x <= (employeeVinoMorale.x + bar.width + step) && mouseLoc.y >= employeeVinoMorale.y && mouseLoc.y <= (employeeVinoMorale.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeVinoMorale.x) / step);
						employeeVinoMorale.width = distance * step;
					}

					if (mouseLoc.x >= employeeDianServices.x && mouseLoc.x <= (employeeDianServices.x + bar.width + step) && mouseLoc.y >= employeeDianServices.y && mouseLoc.y <= (employeeDianServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDianServices.x) / step);
						employeeDianServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeFrandaServices.x && mouseLoc.x <= (employeeFrandaServices.x + bar.width + step) && mouseLoc.y >= employeeFrandaServices.y && mouseLoc.y <= (employeeFrandaServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaServices.x) / step);
						employeeFrandaServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeDavidServices.x && mouseLoc.x <= (employeeDavidServices.x + bar.width + step) && mouseLoc.y >= employeeDavidServices.y && mouseLoc.y <= (employeeDavidServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaServices.x) / step);
						employeeDavidServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeDhiniServices.x && mouseLoc.x <= (employeeDhiniServices.x + bar.width + step) && mouseLoc.y >= employeeDhiniServices.y && mouseLoc.y <= (employeeDhiniServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDhiniServices.x) / step);
						employeeDhiniServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeChristianServices.x && mouseLoc.x <= (employeeChristianServices.x + bar.width + step) && mouseLoc.y >= employeeChristianServices.y && mouseLoc.y <= (employeeChristianServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeChristianServices.x) / step);
						employeeChristianServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeRezaServices.x && mouseLoc.x <= (employeeRezaServices.x + bar.width + step) && mouseLoc.y >= employeeRezaServices.y && mouseLoc.y <= (employeeRezaServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeRezaServices.x) / step);
						employeeRezaServices.width = distance * step;
					}
					if (mouseLoc.x >= employeeVinoServices.x && mouseLoc.x <= (employeeVinoServices.x + bar.width + step) && mouseLoc.y >= employeeVinoServices.y && mouseLoc.y <= (employeeVinoServices.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeVinoServices.x) / step);
						employeeVinoServices.width = distance * step;
					}

					if (mouseLoc.x >= employeeDianProductivity.x && mouseLoc.x <= (employeeDianProductivity.x + bar.width + step) && mouseLoc.y >= employeeDianProductivity.y && mouseLoc.y <= (employeeDianProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDianProductivity.x) / step);
						employeeDianProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeFrandaProductivity.x && mouseLoc.x <= (employeeFrandaProductivity.x + bar.width + step) && mouseLoc.y >= employeeFrandaProductivity.y && mouseLoc.y <= (employeeFrandaProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaProductivity.x) / step);
						employeeFrandaProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeDavidProductivity.x && mouseLoc.x <= (employeeDavidProductivity.x + bar.width + step) && mouseLoc.y >= employeeDavidProductivity.y && mouseLoc.y <= (employeeDavidProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeFrandaProductivity.x) / step);
						employeeDavidProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeDhiniProductivity.x && mouseLoc.x <= (employeeDhiniProductivity.x + bar.width + step) && mouseLoc.y >= employeeDhiniProductivity.y && mouseLoc.y <= (employeeDhiniProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeDhiniProductivity.x) / step);
						employeeDhiniProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeChristianProductivity.x && mouseLoc.x <= (employeeChristianProductivity.x + bar.width + step) && mouseLoc.y >= employeeChristianProductivity.y && mouseLoc.y <= (employeeChristianProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeChristianProductivity.x) / step);
						employeeChristianProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeRezaProductivity.x && mouseLoc.x <= (employeeRezaProductivity.x + bar.width + step) && mouseLoc.y >= employeeRezaProductivity.y && mouseLoc.y <= (employeeRezaProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeRezaProductivity.x) / step);
						employeeRezaProductivity.width = distance * step;
					}
					if (mouseLoc.x >= employeeVinoProductivity.x && mouseLoc.x <= (employeeVinoProductivity.x + bar.width + step) && mouseLoc.y >= employeeVinoProductivity.y && mouseLoc.y <= (employeeVinoProductivity.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - employeeVinoProductivity.x) / step);
						employeeVinoProductivity.width = distance * step;
					}

					// advertisement
					if (mouseLoc.x >= adverTv.x && mouseLoc.x <= (adverTv.x + bar.width + step) && mouseLoc.y >= adverTv.y && mouseLoc.y <= (adverTv.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverTv.x) / step);
						adverTv.width = distance * step;
					}

					if (mouseLoc.x >= adverRadio.x && mouseLoc.x <= (adverRadio.x + bar.width + step) && mouseLoc.y >= adverRadio.y && mouseLoc.y <= (adverRadio.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverRadio.x) / step);
						adverRadio.width = distance * step;
					}

					if (mouseLoc.x >= adverNews.x && mouseLoc.x <= (adverNews.x + bar.width + step) && mouseLoc.y >= adverNews.y && mouseLoc.y <= (adverNews.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverNews.x) / step);
						adverNews.width = distance * step;
					}

					if (mouseLoc.x >= adverInternet.x && mouseLoc.x <= (adverInternet.x + bar.width + step) && mouseLoc.y >= adverInternet.y && mouseLoc.y <= (adverInternet.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverInternet.x) / step);
						adverInternet.width = distance * step;
					}

					if (mouseLoc.x >= adverEvent.x && mouseLoc.x <= (adverEvent.x + bar.width + step) && mouseLoc.y >= adverEvent.y && mouseLoc.y <= (adverEvent.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverEvent.x) / step);
						adverEvent.width = distance * step;
					}

					if (mouseLoc.x >= adverBillboard.x && mouseLoc.x <= (adverBillboard.x + bar.width + step) && mouseLoc.y >= adverBillboard.y && mouseLoc.y <= (adverBillboard.y + bar.height))
					{
						distance = Math.floor((mouseLoc.x - adverBillboard.x) / step);
						adverBillboard.width = distance * step;
					}
				}

				// research
				if (touch.getTouch(researchMarketing, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(researchServices, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(researchPointsale, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(researchProduct, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(researchFacility, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				// incentive
				if (touch.getTouch(incentiveReward, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(incentiveCareer, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(incentiveCultural, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(incentivePersonalization, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(incentiveManagement, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}


				// benefit
				if (touch.getTouch(benefitHealth, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(benefitEducation, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(benefitAdditional, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(benefitPolice, TouchPhase.ENDED))
				{
					if (Quad(touch.target).color == 0xCCCCCC)
					{
						Quad(touch.target).color = 0xFF7979;
					}
					else
					{
						Quad(touch.target).color = 0xCCCCCC
					}
				}

				if (touch.getTouch(buttonClose, TouchPhase.ENDED))
				{
					// getShopData();
				}
			}
		}
		
		/**
		 * Get shop name.
		 * 
		 * @return 
		 */
		public override function get name():String{
			return this.shopName;
		}
		
		/**
		 * Get advertisement data.
		 * 
		 * @return 
		 */
		public function get advertisement():Object{
			var adver:Object = new Object();
			adver.tv = adverTv.width / 5;
			adver.radio = adverRadio.width / 5;
			adver.newspaper = adverNews.width / 5;
			adver.internet = adverInternet.width / 5;
			adver.event = adverEvent.width / 5;
			adver.billboard = adverBillboard.width / 5;
			return adver;
		}
		
		/**
		 * Get product price.
		 * 
		 * @return 
		 */
		public function get price():Object{
			var price:Object = new Object();
			price.food1 = priceFood1.width / 2;
			price.food2 = priceFood2.width / 2;
			price.food3 = priceFood3.width / 2;
			price.drink1 = priceDrink1.width / 2;
			price.drink2 = priceDrink2.width / 2;
			return price;
		}
		
		/**
		 * Get product quality.
		 * 
		 * @return 
		 */
		public function get quality():Object{
			var quality:Object = new Object();
			var quality1:int = qualityFood1.width / 5;
			var quality2:int = qualityFood2.width / 5;
			var quality3:int = qualityFood3.width / 5;
			var quality4:int = qualityDrink1.width / 5;
			var quality5:int = qualityDrink2.width / 5;
			
			quality.food1 = [quality1, quality1, quality1];
			quality.food2 = [quality2, quality2];
			quality.food3 = [quality3, quality3];
			quality.drink1 = [quality4, quality4, quality4];
			quality.drink2 = [quality5, quality5];
			return quality;
		}
		
		/**
		 * Get shop decoration.
		 * 
		 * @return 
		 */
		public function get decoration():Object{
			var decoration:Object = new Object();
			decoration.modern = decorationModern.width / 5;
			decoration.colorfull = decorationColorfull.width / 5;
			decoration.vintage = decorationVintage.width / 5;
			return decoration;
		}
		
		/**
		 * Get shop cleaness.
		 * 
		 * @return 
		 */
		public function get cleaness():Object{
			var cleaness:Object = new Object();
			cleaness.product = cleanessProduct.width / 5;
			cleaness.place = cleanessPlace.width / 5;
			return cleaness;
		}
		
		/**
		 * Get shop scent.
		 * 
		 * @return 
		 */
		public function get scent():Object{
			var scent:Object = new Object();
			scent.ginger = scentGinger.width / 5;
			scent.jasmine = scentJasmine.width / 5;
			scent.rosemary = scentRosemary.width / 5;
			return scent;
		}
		
		/**
		 * Get employee service.
		 * 
		 * @return 
		 */
		public function get service():Array{
			var service:Array = [
				employeeDianServices.width / 5,
				employeeFrandaServices.width / 5,
				employeeDavidServices.width / 5,
				employeeDhiniServices.width / 5,
				employeeChristianServices.width / 5,
				employeeRezaServices.width / 5,
				employeeVinoServices.width / 5
			];
			return service;
		}
		
		/**
		 * Get employe morale.
		 * 
		 * @return 
		 */
		public function get morale():Array{
			var morale:Array = [
				employeeDianMorale.width / 5,
				employeeFrandaMorale.width / 5,
				employeeDavidMorale.width / 5,
				employeeDhiniMorale.width / 5,
				employeeChristianMorale.width / 5,
				employeeRezaMorale.width / 5,
				employeeVinoMorale.width / 5
			];
			return morale;
		}
		
		/**
		 * Get employee productivity.
		 * 
		 * @return 
		 */
		public function get productivity():Array{
			var productivity:Array = [
				employeeDianProductivity.width / 5,
				employeeFrandaProductivity.width / 5,
				employeeDavidProductivity.width / 5,
				employeeDhiniProductivity.width / 5,
				employeeChristianProductivity.width / 5,
				employeeRezaProductivity.width / 5,
				employeeVinoProductivity.width / 5
			];
			return productivity;
		}
		
		/**
		 * Get shop research.
		 * 
		 * @return 
		 */
		public function get research():Object{
			var research:Object = new Object();
			research.marketing = researchMarketing.color == 0xFF7979 ? 1 : 0;
			research.service = researchServices.color == 0xFF7979 ? 1 : 0;
			research.pos = researchPointsale.color == 0xFF7979 ? 1 : 0;
			research.product = researchProduct.color == 0xFF7979 ? 1 : 0;
			research.facility = researchFacility.color == 0xFF7979 ? 1 : 0;
			return research;
		}
		
		/**
		 * Get employee benefit.
		 * 
		 * @return 
		 */
		public function get benefit():Object{
			var benefit:Object = new Object();
			benefit.reward = incentiveReward.color == 0xFF7979 ? 1 : 0;
			benefit.career = incentiveCareer.color == 0xFF7979 ? 1 : 0;
			benefit.culture = incentiveCultural.color == 0xFF7979 ? 1 : 0;
			benefit.personalization = incentivePersonalization.color == 0xFF7979 ? 1 : 0;
			benefit.management = incentiveManagement.color == 0xFF7979 ? 1 : 0;
			benefit.health = benefitHealth.color == 0xFF7979 ? 1 : 0;
			benefit.education = benefitEducation.color == 0xFF7979 ? 1 : 0;
			benefit.financial = benefitAdditional.color == 0xFF7979 ? 1 : 0;
			benefit.practice = benefitPolice.color == 0xFF7979 ? 1 : 0;
			return benefit;
		}
		
		/**
		 * Get booster data.
		 * 
		 * @return 
		 */
		public function get booster():Object{
			var booster:Object = new Object();
			booster.shop = boosterShop.width / 5;
			booster.product = boosterProduct.width / 5;
			booster.employee = boosterEmployee.width / 5;
			booster.lucky = boosterLucky.width / 5;
			return booster;
		}

		/**
		 * Print shop data
		 */
		public function getShopData():void
		{
			trace("Shop " + shopName);
			trace("-----------------------------");
			trace("-- decoration --------------");
			trace("---- modern", decorationModern.width / 5);
			trace("---- colorfull", decorationColorfull.width / 5);
			trace("---- vintage", decorationVintage.width / 5);
			trace("-- cleaness --------------");
			trace("---- product", cleanessProduct.width / 5);
			trace("---- place", cleanessPlace.width / 5);
			trace("-- scent --------------");
			trace("---- ginger", scentGinger.width / 5);
			trace("---- jasmine", scentJasmine.width / 5);
			trace("---- rosemary", scentRosemary.width / 5);
			trace("-- product -------------------");
			trace("--- food");
			trace("---- food1 price", priceFood1.width / 2, "quality", qualityFood1.width / 5);
			trace("---- food2 price", priceFood2.width / 2, "quality", qualityFood2.width / 5);
			trace("---- food3 price", priceFood3.width / 2, "quality", qualityFood3.width / 5);
			trace("--- drink");
			trace("---- drink1 price", priceDrink1.width / 2, "quality", qualityDrink1.width / 5);
			trace("---- drink2 price", priceDrink2.width / 2, "quality", qualityDrink2.width / 5);
			trace("-- advertisement ---------------");
			trace("---- tv", adverTv.width / 5);
			trace("---- radio", adverRadio.width / 5);
			trace("---- newspaper", adverNews.width / 5);
			trace("---- internet", adverInternet.width / 5);
			trace("---- event", adverEvent.width / 5);
			trace("---- billboard", adverBillboard.width / 5);
			trace("-- employee ---------------");
			trace("---- dian", employeeDianMorale.width / 5, employeeDianServices.width / 5, employeeDianProductivity.width / 5);
			trace("---- franda", employeeFrandaMorale.width / 5, employeeFrandaServices.width / 5, employeeFrandaProductivity.width / 5);
			trace("---- david", employeeDavidMorale.width / 5, employeeDavidServices.width / 5, employeeDavidProductivity.width / 5);
			trace("---- dhini", employeeDhiniMorale.width / 5, employeeDhiniServices.width / 5, employeeDhiniProductivity.width / 5);
			trace("---- christian", employeeChristianMorale.width / 5, employeeChristianServices.width / 5, employeeChristianProductivity.width / 5);
			trace("---- reza", employeeRezaMorale.width / 5, employeeRezaServices.width / 5, employeeRezaProductivity.width / 5);
			trace("---- vino", employeeVinoMorale.width / 5, employeeVinoServices.width / 5, employeeVinoProductivity.width / 5);
			trace("-- booster ---------------");
			trace("---- shop", boosterShop.width / 5);
			trace("---- product", boosterProduct.width / 5);
			trace("---- employee", boosterEmployee.width / 5);
			trace("---- lucky", boosterLucky.width / 5);
			trace("-- research ---------------");
			trace("---- marketing", (researchMarketing.color == 0xFF7979) ? 1 : 0);
			trace("---- service", (researchServices.color == 0xFF7979) ? 1 : 0);
			trace("---- pos", (researchPointsale.color == 0xFF7979) ? 1 : 0);
			trace("---- product", (researchProduct.color == 0xFF7979) ? 1 : 0);
			trace("---- facility", (researchFacility.color == 0xFF7979) ? 1 : 0);
			trace("-- incentive --------------");
			trace("---- reward", (incentiveReward.color == 0xFF7979) ? 1 : 0);
			trace("---- career", (incentiveCareer.color == 0xFF7979) ? 1 : 0);
			trace("---- culture", (incentiveCultural.color == 0xFF7979) ? 1 : 0);
			trace("---- personalization", (incentivePersonalization.color == 0xFF7979) ? 1 : 0);
			trace("---- management", (incentiveManagement.color == 0xFF7979) ? 1 : 0);
			trace("-- benefit --------------");
			trace("---- health", (benefitHealth.color == 0xFF7979) ? 1 : 0);
			trace("---- education", (benefitEducation.color == 0xFF7979) ? 1 : 0);
			trace("---- additional financial", (benefitAdditional.color == 0xFF7979) ? 1 : 0);
			trace("---- police practice", (benefitPolice.color == 0xFF7979) ? 1 : 0);
			trace("-----------------------------");
			trace("");
		}
	}
}
