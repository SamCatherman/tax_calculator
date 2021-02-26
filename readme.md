# Tax Calculator
to run - `$ ruby main.rb`

 Imagine there are actually 50+ brackets that change every year, and we need to compute 1
 Billion income tax projections every year
 Describe in a few bullet points how you’d build a solution that scales.

In this solution, I've hardcoded some values making the assumption that with a full Rails application, their structure would be extensible to accomodate much greater variation in income brackets and rates. In my mind, there are a few key aspects to consider when thinking about scaling the program to such a large degree.

### - Modularity: 
I tried to think of brackets and rates as models that could be queried, created, updated, and iterated over to make the process for determining tax liablilty based on income as simple and understandable as possible. To that end, any user hoping to use the program could set their own bracket boundaries and rates to calculate tax amounts due based on a timeframe (given year) or jurisdiction (country, state etc.). The rails framework provides paradigms for managing and authenticating different users, building relationships between data models and an engine for making APIs accessible to end consumers. As the product scales, models could be added and amended to address finer details.

### - Functionality: 
It would be nice to add additional features to this tax amount calculator, including but not limited to APIs that make updating, creating and removing tax brackets, employees and other parameters possible, mailers, exports (CSV, JSON, XML etc), and integration to other services (hr software, banks, govt reporting, turbotax etc). The user experience in my mind could be extended to deliver the requested data in many different formats convenient to various consumers. Income and tax rate data could be fetched from a company's HR system, imported via CSV and/or accessed via REST APIs.

### - Infrastructure: 

A program of this scale would require some pretty robust infrastructure to serve a billion tax projections per year. Recent rails versions now support multiple database connections, to reduce the risk of overload. It may make sense to implement some sort of job queuing protocol like resque to process large batches of tax breakdowns without holding up other areas of the application. Our rails applilcation could be deployed to a cloud service provder like AWS, and take advantange of all of the different scaling and security features offered. These could include load balancing, auto-scaling, lambdas, environment secrets and user management. This is an area where costs can add up, so optimizing the application pre-deployment is a necessary measure. A Docker image or similar container tool would ensure that the application could be built and run smoothly on a remote service provider.

In all, this is a straightforward task made more complex by scale requirements. With 1 billion requests in mind, I made sure to avoid any unnecessary nested loops and keep the calculation logic as straightforward as possible, relying on tools offered by the rails framework and modern architectural solutions to handle challenges posed by scaling up. Thank you for taking the time to read my submission, I look forward to discussing it further at your convenience!

#### Sam Catherman 2021