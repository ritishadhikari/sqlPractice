USE org;

-- 1. Create Table Transactions
CREATE table transactions1
	(
		order_id INT,
        cust_id INT,
        order_date DATE,
        amount INT
    );
    
    
-- 2. Insert Values into Transactions
INSERT INTO transactions1
	(order_id,cust_id,order_date,amount)
    VALUES
    (1,1,'2020-01-15',150)
	,(2,1,'2020-02-10',150)
	,(3,2,'2020-01-16',150)
	,(4,2,'2020-02-25',150)
	,(5,3,'2020-01-10',150)
	,(6,3,'2020-02-20',150)
	,(7,4,'2020-01-20',150)
	,(8,5,'2020-02-20',150);


SELECT 
	*
FROM 
	transactions1;

/*
	Customer retention refers to a company's ability to turn customers 
    into repeat buyers and prevent them from switching to a competitor. 
	It indicates whether your product and the quality of your service 
    please your existing customers 
		- reward programs ( cc companies)
        - wallet cash back (paytm, gpay)
        - zomato pro/ swiggy super
*/

-- No data for dec, 2019; hence no retention for Jan, 2020.
-- feb, 3 customer retained (custid - 1,2,3)
/*
TId	Res	TM	LM	LID
1	0	1	12	N	# Not Applicable for Right Join
2	0	1	12	N	# Not Applicable for Right Join
3	0	1	12	N	# Not Applicable for Right Join	
4	0	1	12	N	# Not Applicable for Right Join
1   1	2	1	1
2	1	2	1	2
3	1	2	1	3
5	0	2	1	N
N	0	2	1	4	# Not applicable for Left Join


*/
SELECT 
	MONTH(thisMonth.order_date) AS this_month
	, COUNT(DISTINCT lastMonth.cust_id) AS retained_count
FROM 
	transactions1 thisMonth
	LEFT JOIN
	transactions1 lastMonth
	ON
	thisMonth.cust_id=lastMonth.cust_id
	AND
	MONTH(thisMonth.order_date)-MONTH(lastMonth.order_date)=1	
GROUP BY 
	MONTH(thisMonth.order_date);
    

