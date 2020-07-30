
/***************************************************************************************************/
select *
from [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
select *
from ORG_INFO

SELECT
  supplierTable.供應商,
  supplierTable.供餐機構,
  COUNT(*) AS 供應次數
FROM (SELECT
    DISTINCT
    [MDF_InDate] AS 進貨日期,
    [MDH_DATE] AS 菜單日期,
    [MDH_BID_CH] AS 供餐機構,
    [MDF_Name] AS 食材名稱,
    [MDF_Supplier] AS 供應商,
    [MDF_Manufacturer] AS 製造商
  FROM [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
  WHERE 
--[MDH_BID_CH] LIKE '%上將%'
MDF_Name IS NOT NULL
    AND (MDF_Name LIKE '%肉%'
    OR MDF_Name LIKE '%骨%'
    OR MDF_Name LIKE '%胸%'
    OR MDF_Name LIKE '%魚%')) AS supplierTable
  LEFT JOIN ORG_INFO as OI on OI.O_ID = supplierTable.MDH_BID
GROUP BY supplierTable.供應商, supplierTable.供餐機構
ORDER BY COUNT(*) DESC

/***************************************************************************************************/

SELECT
  DISTINCT
  [MDF_InDate] AS 進貨日期,
  [MDH_DATE] AS 菜單日期,
  [MDH_BID_CH] AS 供餐機構,
  [MDF_Name] AS 食材名稱,
  [MDF_Supplier] AS 供應商,
  [MDF_Manufacturer] AS 製造商
FROM [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
--where [MDH_BID_CH] like '%%' 
--or [MDH_BID_CH] like '%統鮮%' 
--or [MDH_BID_CH] like '%雙翼%'
WHERE MDF_Name IS NOT NULL
  AND [MDH_BID_CH] LIKE '%上將%'
  AND (MDF_Name LIKE '%肉%'
  OR MDF_Name LIKE '%骨%'
  OR MDF_Name LIKE '%胸%'
  OR MDF_Name LIKE '%魚%')
  AND [MDF_Supplier] = '萬偉股份有限公司'
--and (
--MDF_Name like '%液蛋%' )
ORDER BY [菜單日期]

/***************************************************************************************************/
/*以下驗證資料正確性*/
SELECT
  MDF_Supplier,
  COUNT(*)
FROM [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
WHERE MDH_BID_CH LIKE '%上將%'
  AND MDF_Name IS NOT NULL
  AND (MDF_Name LIKE '%肉%'
  OR MDF_Name LIKE '%骨%'
  OR MDF_Name LIKE '%胸%'
  OR MDF_Name LIKE '%魚%')
GROUP BY MDF_Supplier
ORDER BY COUNT(*) DESC

/************/
select *
from [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
select *
from ORG_INFO

SELECT
  --supplierTable.菜單日期,
  supplierTable.進貨日期,
  supplierTable.供應商,
  supplierTable.供餐機構,
  COUNT(*) AS 供應次數
FROM (SELECT
    DISTINCT
    [MDH_BID],
    [MDF_InDate] AS 進貨日期,
    --[MDH_DATE] AS 菜單日期,
    [MDH_BID_CH] AS 供餐機構,
    [MDF_Name] AS 食材名稱,
    [MDF_Supplier] AS 供應商
  --[MDF_Manufacturer] AS 製造商
  FROM [NTP_FoodMonitor].[dbo].[V_MenuDayFood_CH] ayFood
    LEFT JOIN ORG_INFO AS OI ON OI.O_ID = MDH_BID
  WHERE 
O_GroupMeal_FLAG='Y'
    AND MDF_Name IS NOT NULL
    AND (MDF_Name LIKE '%肉%'
    OR MDF_Name LIKE '%骨%'
    OR MDF_Name LIKE '%胸%'
    OR MDF_Name LIKE '%魚%')) AS supplierTable
GROUP BY supplierTable.供應商, supplierTable.供餐機構,supplierTable.進貨日期
ORDER BY supplierTable.進貨日期
--ORDER BY COUNT(*) DESC