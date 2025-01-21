--https://datalemur.com/questions/non-profitable-drugs
/*Pharmacy Analytics (Part 2)
CVS Health SQL Interview QuestionCVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market.
Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and 
calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value.
Display the results sorted in descending order with the highest losses displayed at the top.*/

CREATE TABLE pharmacy_sales (
    product_id INT NOT NULL,
    units_sold INT NOT NULL,
    total_sales DECIMAL(18, 2) NOT NULL,
    cogs DECIMAL(18, 2) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    drug VARCHAR(255) NOT NULL,
    PRIMARY KEY (product_id)
);

INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) 
VALUES
(156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
(25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
(41, 189925, 3499574.92, 3692136.66, 'AbbVie', 'Clarithromycin'),
(63, 93513, 2104765.00, 2462370.76, 'Johnson & Johnson', 'Pepcid AC Acid Reducer'),
(8, 177270, 2930134.52, 3035522.06, 'Johnson & Johnson', 'Nicorobin Clean and Clear'),
(75, 164674, 1184664.57, 1285326.93, 'Eli Lilly', 'RED GINSENG FERMENTED ESSENCE BB'),
(91, 97765, 1115255.32, 1201044.27, 'Roche', 'Hydrochlorothiazide'),
(26, 126866, 1499768.09, 1573992.41, 'Eli Lilly', 'LBel'),
(16, 51707, 1304837.86, 1378790.53, 'Roche', 'Topcare Tussin'),
(80, 61467, 3740527.69, 3804542.20, 'Biogen', 'Losartan Potassium'),
(148, 104637, 837620.18, 931084.25, 'Johnson & Johnson', 'Motrin'),
(95, 128494, 723841.23, 779520.88, 'Biogen', 'Wal-Zan'),
(56, 86598, 1755300.92, 1806344.97, 'Eli Lilly', 'Spot Repairing Serum'),
(71, 126265, 2564743.39, 2593528.67, 'Bayer', 'ENALAPRIL MALEATE'),
(35, 87449, 86938.27, 99811.26, 'Johnson & Johnson', 'Sanitary Wipes Plus'),
(70, 167190, 1119479.36, 1313174.69, 'Johnson & Johnson', 'Zyrtec Ultra-Strength'),
(15, 118901, 2717420.96, 2707620.02, 'Biogen', 'Clotrimazole'),
(33, 149895, 949514.05, 921206.75, 'Bayer', 'Levofloxacin'),
(179, 125006, 1825970.00, 1769907.97, 'Biogen', 'Lancome Paris Renergie Lift Volumetry'),
(21, 50550, 697276.33, 640063.57, 'Pfizer', 'Venlafaxine Hydrochloride'),
(125, 101102, 566696.00, 508144.71, 'AbbVie', 'Lidocaine Hydrochloride and Epinephri'),
(76, 87699, 3257976.38, 3389863.82, 'Johnson & Johnson', 'EltaMD SPF 150 Sun Screen'),
(136, 144814, 1084258.00, 1006447.73, 'Biogen', 'Burkhart'),
(34, 94698, 600997.19, 521182.16, 'AstraZeneca', 'Surmontil'),
(61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
(9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
(67, 87756, 1112253.82, 1021908.39, 'Biogen', 'Pramipexole Dihydrochloride'),
(105, 97736, 537795.00, 426539.59, 'Pfizer', 'Diaper Rash Skin Protectant Crema Cer'),
(107, 160617, 2538701.50, 2414037.51, 'Biogen', 'N - TIME SINUS'),
(89, 61832, 1084996.13, 940593.68, 'Sanofi', 'Locoid'),
(30, 142661, 1615518.35, 1439533.27, 'Sanofi', 'Oxaprozin'),
(47, 130448, 461623.76, 282038.76, 'Eli Lilly', 'Night Time Cherry Syrup'),
(146, 71159, 1778024.00, 1598276.66, 'AstraZeneca', 'PDI Sani-Hands for Kids'),
(52, 47310, 1151498.60, 956693.99, 'AstraZeneca', 'Armour Thyroid'),
(183, 155058, 1220029.58, 1023275.76, 'AbbVie', 'Lexapro'),
(113, 122655, 1358711.57, 1161623.36, 'Novartis', 'Famotidine'),
(29, 217652, 3106931.54, 2898165.87, 'AstraZeneca', 'MiraLAX'),
(171, 177686, 632705.44, 413382.39, 'AstraZeneca', 'lansoprazole'),
(2, 284705, 523311.90, 302721.56, 'Novartis', 'Imatinib'),
(126, 165665, 586961.45, 365016.10, 'AbbVie', 'Hamamelis Virginiana Kit Refill');


--CALCULATE AND DISPLAY THE MANUFACTURERS IN THE ASCENDING ORDER OF LOSS.

SELECT manufacturer,
	   count(drug) as drug_count,
	   abs(sum(total_sales-cogs)) as net_loss
FROM pharmacy_sales
WHERE (total_sales-cogs)<=0
GROUP BY manufacturer
ORDER BY net_loss desc

--https://datalemur.com/questions/total-drugs-sales

SELECT manufacturer,
       CONCAT('$',ROUND(SUM(total_sales)/1000000,0),' million') as sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC,manufacturer;
