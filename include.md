# Local Food Prices

This is a display of the food price data used in the paper "Local Food Prices, SNAP Purchasing Power, and Child Health"
by Erin Bronchetti, Garret Christensen, and Hilary Hoynes. Send questions to Garret Christensen, or download the code from [Github](http://www.github.com/garretchristensen/Food_Price_Maps).

The data originally comes from the USDA's Quarterly Food at Home Price Database ([QFAHPD](https://www.ers.usda.gov/data-products/quarterly-food-at-home-price-database/)).
We follow the method described in Gregory, Coleman-Jensen (2013--[published](https://academic.oup.com/aepp/article/35/4/679/8547/Do-High-Food-Prices-Increase-Food-Insecurity-in), [OA](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1850545)) to turn regional data on food category prices into a single regional index modeled after the Thrifty Food Plan. The country is divided into 30 regions, and price data originally comes from [Nielsen Homescan](https://www.ers.usda.gov/publications/pub-details/?pubid=46114) data. Our price index doesn't exactly match the TFP since the TFP uses low-income shopper behavior.)

The point is: there's a lot of variation over time and across regions. SNAP benefits, however, are not adjusted to account for the regional variation, and are instead based on a national average. ($99 in 1999, increasing to $134 by 2010. Source: [USDA](https://www.cnpp.usda.gov/USDAFoodPlansCostofFood/reports))
