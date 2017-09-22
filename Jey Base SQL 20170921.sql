-- Last modified:
-- Andrew
-- Sep 20, 2017

select 
-------------------------JP
defn_task.task as tasknum, 
(select max(jp) from temp_pmjp) + rownum as jpnum, ----use next JPNUM per DB $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'GTAA' as orgid,
'YYZ' as siteid,
0 as pluscrevnum,
0 as gt1regulatory,
0 as gtplanreq,
1 as gtschedreq,
'ANYTIME' as shifttype,
'ACTIVE' as status,
master_card_task.estimated_hours as jpduration,  ---when not using route stops
--(defn_task.standard_task_time / 60/ defn_task.crew_size) jpduration, ---when using route stops
'' persongroup, --$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--'ELECTRICAL-BUILDINGS' persongroup, --$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--'BMS' persongroup, --$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'' ownergroup, 
case maximofrequency when '01-DAYS' then 3
when '01-WEEKS' then 4 
else 5
end priority,
1013 as classstructureid,
temp_amms_maximo_loc.comments as j0001, 
--'CUSTODIAL' as j0001, 
'SBM' as j0002, maximofrequency as j0003, 
defn_task.task || ' / ' || MASTER_CARD.MASTER_CARD_NO as j0004, --amms tasknumber 
master_card_task.planned_accomplishment as j0005, --amms number of route stops
'YES' as j0006, --Temporary Job Plan  
--as j0007, --Route Stops Created
'' as  s0003, --system 
case defn_task.task  

when '1' then ''
when '1L14M' then 'D'
when '1L17Z' then 'D'
when '1L22M' then 'B'
when '1L28W' then 'C'
else ''
end s0011, -- subsystem
defn_task.task_name as sdesc, 
---------------------------JT

(select max(jp) from temp_pmjp) + rownum as jobtask_jpnum, ----use next JPNUM per DB $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'GTAA' as jobtask_orgid,
'YYZ' as jobtask_siteid,
0 as jobtask_pluscrevnum,
10 as jobtask_jptask,
'PERFORM JOB PLAN BASED ON STEPS LISTED IN THE LONG DESCRIPTION' as jobtask_description,
1 as jobtask_hasld,
task_details as jobtask_ld,  --#################################

----------------------------JL
(select max(jp) from temp_pmjp) + rownum as joblabor_jpnum,
'GTAA' as joblabor_orgid, 
'YYZ' as joblabor_siteid, 
0 as joblabor_pluscrevnum, 
'ACTIVE' as joblabor_status, 
defn_task.crew_size as joblabor_quantity, 
(defn_task.standard_task_time / 60/ defn_task.crew_size) * master_card_task.planned_accomplishment as joblabor_laborhrs, ---when not using route stops
--(defn_task.standard_task_time / 60/ defn_task.crew_size) as joblabor_laborhrs, ---when using route stops
lead_craft as joblabor_craft,
--'CUSTODIAL' as joblabor_craft,
'JOURNEYMAN' as joblabor_skilllevel, 
0 as joblabor_pluscjprevnum,

----------------------------PM
(select max(pm) from temp_pmjp) + rownum  as pm_pmnum,  -- use next PMNUM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'YYZ' as pm_siteid,
case defn_location.location 
when '1ATN' then 'T1'
when '1AREA3' then 'T3'
when '1AT3' then 'T3'
when '1AT3SAT' then 'T3'
when '16BPG' then '6BPG [VALUE PARK GARAGE]'
when '1APMAT1' then 'T1APM'
when '1APMVIS' then 'VISAPM'
when '1CVHAT3B' then 'T3 CVHA ELECT BLDG FOR'
when '1CVHAT3B2' then 'T3 CVHA TAXI/LIMO DRIVERS BLDG'
when '1SLS9' then 'T1 PKG GARAGE-SEWAGE LIFT STN AREA 9-BLDG SANITARY'
when '1SLS6A' then 'T3 SEWAGE LIFT STATION AREA 6A'
when '1SPS3' then 'T3 SEWAGE PUMPING STATION'
when '1ATNAP' then 'T1-AS-APRON'
when '1AT3AP' then 'T3-AS-APRON'
when '1RDSERT1BAG' then 'AIRSIDE-ROADWAYS-SERVICE ROADS-TERMINAL 1 BAGGAGE SERVICE RD'
else defn_location.location
end----------------------------wwwwwwwwwwwwwwwww  
|| ', ' || master_card.room_no || ', ' || master_card.column_no as pm_description, 
'DRAFT' as pm_status,
'' as pm_location, '' as pm_assetnum, '' as pm_route, 
'SBM' as pm_worktype,
'WASSIGN' as pm_wostatus, 
substr(maximofrequency,1,2) as pm_frequency, 
substr(maximofrequency,4,length(maximofrequency)) as pm_frequnit, 
'12/1/17' as pm_nextdate, 
'' as "PM.TARGSTARTTIME", -------------------------------------------------------------------------------------------------------------------------------------------------------------
14 as pm_leadtime, 
(select max(jp) from temp_pmjp) + rownum as pm_jpnum,   --use next JPNUM  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
master_card.work_instructions as pm_description_ld,  --###############################
--------------------------
master_card.master_card_no as mc_num,
case defn_location.location 
when '1ATN' then 'T1'
when '1AREA3' then 'T3'
when '1AT3' then 'T3'
when '1AT3SAT' then 'T3'
when '16BPG' then '6BPG [VALUE PARK GARAGE]'
when '1APMAT1' then 'T1APM'
when '1APMVIS' then 'VISAPM'
when '1CVHAT3B' then 'T3 CVHA ELECT BLDG FOR'
when '1CVHAT3B2' then 'T3 CVHA TAXI/LIMO DRIVERS BLDG'
when '1SLS9' then 'T1 PKG GARAGE-SEWAGE LIFT STN AREA 9-BLDG SANITARY'
when '1SLS6A' then 'T3 SEWAGE LIFT STATION AREA 6A'
when '1SPS3' then 'T3 SEWAGE PUMPING STATION'
when '1ATNAP' then 'T1-AS-APRON'
when '1AT3AP' then 'T3-AS-APRON'
when '1RDSERT1BAG' then 'AIRSIDE-ROADWAYS-SERVICE ROADS-TERMINAL 1 BAGGAGE SERVICE RD'
else defn_location.location
end as mc_location,
master_card.room_no as mc_room_no , 
master_card.column_no as mc_column_no, 
defn_measure.measure as measure,
MC_SHIFT.SHIFT as seasonal,
DEFN_COMPONENT_GENERIC.COMPONENT_GENERIC
from 
defn_measure, defn_task, defn_trade_shop, temp_amms_maximo_loc, temp_amms_maximo_fq, master_card_task, master_card, defn_location, defn_component_generic, MC_SHIFT
where
defn_task.task_measure_id = defn_measure.id (+)
and defn_trade_shop.trade_shop = temp_amms_maximo_loc.trade_shop
and defn_task.trade_shop_id = defn_trade_shop.id
and substr(defn_task.task, -1, 1) = temp_amms_maximo_fq.amms_frequency
and temp_amms_maximo_fq.amms_frequency is not null
and defn_task.id (+)= master_card_task.task_id 
and master_card_task.master_card_id (+)  = master_card.id 
and master_card.location_id = defn_location.id
and MASTER_CARD.WORK_ORDER_PRIORITY <> 4  -- MC priority 5 not to be included
and  DEFN_COMPONENT_GENERIC.ID (+) = MASTER_CARD.GENERIC_ID 
and MASTER_CARD.ID  = MC_shift.master_card_id (+)
--and MASTER_CARD.MASTER_CARD_NO = '0916'
--and defn_task.task in ( '1L14M', '1L17Z', '1L22M', '1L28W')
--and defn_task.task in ('1F17Z', '1F28W' ,'1F29M' ,'1F04Q' ,'1F14M' ,'1B35M')
--and DEFN_TRADE_SHOP.TRADE_SHOP = 'HUR'
--and defn_task.task in ( '2129A', '2176M')

--and defn_task.task in ( '1L24M' ,'1F24M' ,'22L2M' )

and defn_task.task in ('1A03A','1A03M','1A05A','1A05M','1A06M','1A17S')  --group 1
--and defn_task.task in ('1A18A','1A18M','1A19M','1A20A','1A21A')  --group 2
--and defn_task.task in ('1A30M','1A31Q','1A32Q','1A33S','1A34M','1A61A')  --group 3
--and defn_task.task in ('1A13A','1A13M','1A24S','1A25A') --group 4
--and defn_task.task in ('1A04A','1A26S','1A35Q','1A36M','1A37M','1A38A','1A39Q')  --group 5



--and  DEFN_COMPONENT_GENERIC.COMPONENT_GENERIC is null

--ELECTRICIAN  ELEC



/*('22022',
'22062',
'22132',
'22222',
'22242',
'22272',
'22822',
'22912',
'2191A',
'2202A',
'2204M',
'2205M',
'2206A',
'2207W',
'2212A',
'2213A',
'2213M',
'2219S',
'2219Z',
'2221S',
'2234A',
'2234Q',
'2248A',
'2251S',
'2256S',
'2259A',
'2259Q',
'2269M',
'2276M',
'2277M',
'2277W'
) -- AZMINA */
--('2191A','22912','22022','2202A','2204M','2205M','2213M','2221S','22062','2206A','2207W','2256S','2269M','2212A','22132','2213A','2251S','2219Z','2219S','2276M','22222','22242','22272','2234A','2234Q','2259A','2259Q','2248A','2277M','2277W','22822')
--('22M5M', '22M5Q') --Jey -- JPNUM, PMNUM
--('3011A', '3011M') --Jey -- JPNUM, PMNUM
--('1M11W','1M11D','1M07W','1M05S','1M03W','1M04D','1M04W','1M08D','1M10A','1M09A','1M12S','1M02M','1M08M')  --Scott
--('2191A', '22912', '22022', '2202A') -- Group1 --  18300
--('2204M', '2205M', '2213M', '2221S') --Group2 -- 19038
--('22062', '2206A') --Group3 -- 19050
--('2207W', '2256S', '2269M') --Group4 -- 19131
--('2212A', '22132', '2213A','2251S','2219Z') --Group5 -- 19139
--('2219S', '2276M') --Group6 --19261 
--('22222', '22242', '22272') --Group7 --19300
--('2234A', '2234Q') --Group8 --19588
--('2259A', '2259Q', '2248A') --Group9 --19736
--('2277M', '2277W', '22822') --Group10 --

order by 1,2;

--select * from temp_pmjp;
--update temp_pmjp set PM = 24000, JP = 24000;
--commit;


--select * from temp_amms_maximo_loc

--select * from defn_trade_shop where trade_shop = 'HUR'

--select * from temp_amms_maximo_fq