if(debug)then{['geld', 15000000] call INV_AddInvItem};
StartGeld                = 25000;
if(iscop)then{StartGeld = 25000;};
maxcopbonus		 = 30000;
maxcivbonus 	 	 = 30000;
robb_timeSperre          = 1200;   
local_useBankPossible    = true;  
maxinsafe                = 300000;
BankRaubKontoverlust     = 4000;  
ShopRaubKontovershop     = 0;
ShopRaubProzentVershop   = 0;
rblock			 = 0;
stolencash		 = 0;
Maxbankrobpercentlost    = 0.1; 
bank_steuer              = 5;
zinsen_prozent           = 1;
zinsen_dauer             = 1200;
robenable              	 = true;     
Kontostand               = StartGeld; 
shopflagarray            = [shop1,shop4];
bankflagarray            = [mainbank,copbank,copairbank,copswatbank,copsgtbank,cidbank,copdispatchbank,copsheriffbank,copcmdbank,copcoastguardbank,atm1,atm5,atm6,atm10,atm11,atm12,atm13,IRAatm,atmswag,atmmall,atmsubfire,pmcbank,atmjail,towatm,devatm];
speedcamarray            = [speed1,speed2,speed3,speed4,speed5,speed6,speed7,speed8];
drugsellarray		 = [mdrugsell,cdrugsell,ldrugsell,hdrugsell,whalesell,methsell];
TankstellenArray         = [fuel2,fuel4,fuel5,fuel7,fuel8];

