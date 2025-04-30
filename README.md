# ActBlue Skills Test
This folder contains my submission to the ActBlue Data Analyst skills test. 

## Exercise One: SQL Refactor
In the Exercise1.sql file, I refactor the SQL query given to make it easy to read by teammates and fix the syntax errors. 

## Exercise Two: Storytelling with Data
In the Exercise2.ipynb file I draw insights into the ActBlue's FEC filings and FEC committee datasets from the 2020 cycle.

In my analysis, I decided to use python to explore ActBlue's FEC filings and FEC committee data from the 2020 cycle datasets. This helped me create clear graphs looking into the top 10 democratic congressional committees that received the most out of state donations and the top 10 careers of donors who donate out of state the most. 

**Exploring Data and Integrity Checks:**

The integrity checks I use before analyzing a new dataset are:
1. Exploring the dataset by printing it out to get familiar with the meanings of each column
2. Look at the data types of the columns
3. If there are ints/floats I look at the summary statistics of these numbers to see if they are relevant
4. Look at the sum of null values in each column
5. Check for duplication of rows
6. In order to merge the two datasets, I must extract the committee id from the memo_text_description from fec_filing and join on that

**Merging the datasets:**

I merged the FEC filings dataset and the FEC committee data by first removing the committee ID from the memo_text_description column from the FEC filing data. This allowed me to complete a join on cmte_id on the two datasets. 

**Analysis:**

I created two graphs that show: 
1.   The top 10 congressional committees with the most out-of-state contributions between February and April 2020.
2.   The top 10 donor occupations contributing the most out-of-state donations to these committees.

The first graph shows  that the committees receiving the most out-of-state contributions are generally those with high national visibility, such as AOC, Nancy Pelosi, and Adam Schiff. This shows that  the most prominent committees, rather than those in highly competitive races, attract the most out-of-state support. An interesting note is that the Congressional Black Caucus PAC is the only PAC in the top 10 out-of-state congressional committees (however, out-of-state donations tend to be more significant for individual candidates rather than PACs). This shows that at the beginning of 2020, many donors contributed to the Congressional Black Caucus PAC. An explanation for this could be that February is Black History Month, which could have encouraged people to donate more to that PAC in support of its mission. 

The second graph shows that individuals who donate to out-of-state Democratic congressional committees are primarily employed in white-collar professions that typically require higher education—such as executives, lawyers, and physicians. This suggests that higher-income, highly educated individuals are more likely to donate across state lines to Democratic candidates. While the top occupations donating out-of-state may closely resemble occupations contributing to Democrats overall, the data shows the national engagement of donors in these careers.

**Questions and Future Research:** 

I would be interested in doing a deeper analysis and comparing the top 10 careers donating to Democratic congressional committees vs those contributing to Republican congressional committees. This data is limited to contributions filed through ActBlue, so we would not be able to explore this partisan difference in donor career profiles with this data alone. I'm also interested in looking into how out out-of-state contributions to Democratic congressional candidates evolve over a longer timeframe beyond February to April 2020, to better understand whether these patterns hold consistently across election cycles.
