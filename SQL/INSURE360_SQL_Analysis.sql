-- INSURE360 | SQL Server analysis starter pack
-- Synthetic data. Tables should be imported with the CSV filenames as table names.

-- 1. Row counts and key uniqueness
SELECT 'Dim_Policy' AS TableName, COUNT(*) AS Rows, COUNT(DISTINCT PolicyKey) AS DistinctKeys FROM Dim_Policy
UNION ALL SELECT 'Fact_PremiumPayment', COUNT(*), COUNT(DISTINCT PaymentTransactionKey) FROM Fact_PremiumPayment
UNION ALL SELECT 'Fact_PolicySnapshot', COUNT(*), COUNT(DISTINCT PolicySnapshotKey) FROM Fact_PolicySnapshot;

-- 2. Current portfolio status and annualized premium exposure
SELECT CurrentPolicyStatus, COUNT(*) AS PolicyCount, SUM(AnnualizedPremiumINR) AS AnnualizedPremiumINR
FROM Dim_Policy GROUP BY CurrentPolicyStatus ORDER BY PolicyCount DESC;

-- 3. Lapse rate by product
SELECT pr.ProductName, COUNT(*) AS IssuedPolicies,
 SUM(CASE WHEN p.CurrentPolicyStatus='Lapsed' THEN 1 ELSE 0 END) AS LapsedPolicies,
 CAST(1.0*SUM(CASE WHEN p.CurrentPolicyStatus='Lapsed' THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS DECIMAL(10,4)) AS LapseRate
FROM Dim_Policy p JOIN Dim_Product pr ON p.ProductKey=pr.ProductKey
GROUP BY pr.ProductName ORDER BY LapseRate DESC;

-- 4. Annualized premium attached to lapsed policies by channel (exposure, not realised loss)
SELECT ch.ChannelName, COUNT(*) AS LapsedPolicies, SUM(p.AnnualizedPremiumINR) AS PremiumAtRiskINR
FROM Dim_Policy p JOIN Dim_Channel ch ON p.ChannelKey=ch.ChannelKey
WHERE p.CurrentPolicyStatus='Lapsed' GROUP BY ch.ChannelName ORDER BY PremiumAtRiskINR DESC;

-- 5. Scheduled installment outcomes by payment frequency
SELECT p.PaymentFrequency, COUNT(*) AS ScheduledInstallments,
 SUM(CASE WHEN t.PaymentStatus='Paid' THEN 1 ELSE 0 END) AS Paid,
 SUM(CASE WHEN t.PaymentStatus='Paid Late' THEN 1 ELSE 0 END) AS PaidLate,
 SUM(CASE WHEN t.PaymentStatus='Missed' THEN 1 ELSE 0 END) AS Missed
FROM Fact_PremiumPayment t JOIN Dim_Policy p ON t.PolicyKey=p.PolicyKey
GROUP BY p.PaymentFrequency;

-- 6. Monthly cohort persistency by policy age (check cohort eligibility before comparing older ages)
SELECT DATEFROMPARTS(YEAR(p.IssueDate),MONTH(p.IssueDate),1) AS IssueCohortMonth,
 s.PolicyAgeMonths, COUNT(DISTINCT s.PolicyKey) AS PoliciesObserved,
 COUNT(DISTINCT CASE WHEN s.SnapshotStatus='Active' THEN s.PolicyKey END) AS ActivePolicies
FROM Fact_PolicySnapshot s JOIN Dim_Policy p ON s.PolicyKey=p.PolicyKey
GROUP BY DATEFROMPARTS(YEAR(p.IssueDate),MONTH(p.IssueDate),1),s.PolicyAgeMonths
ORDER BY IssueCohortMonth,s.PolicyAgeMonths;

-- 7. Customers holding more than one policy
SELECT c.CustomerID, COUNT(DISTINCT p.PolicyKey) AS PolicyCount,
 SUM(p.AnnualizedPremiumINR) AS PortfolioAnnualizedPremiumINR
FROM Dim_Customer c JOIN Dim_Policy p ON c.CustomerKey=p.CustomerKey
GROUP BY c.CustomerID HAVING COUNT(DISTINCT p.PolicyKey)>1
ORDER BY PortfolioAnnualizedPremiumINR DESC;

-- 8. Orphan payment records (expected result: zero)
SELECT COUNT(*) AS OrphanPayments FROM Fact_PremiumPayment t
LEFT JOIN Dim_Policy p ON t.PolicyKey=p.PolicyKey WHERE p.PolicyKey IS NULL;
