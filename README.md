Singh, K.S.; Thual, D.; Spurio, R.; Cannata, N.	SaDA: From Sampling to Data Analysis—An Extensible Open Source Infrastructure for Rapid, Robust and Automated Management and Analysis of Modern Ecological High-Throughput Microarray Data. Int. J. Environ. Res. Public Health 2015, 12, 6352-6366



Monitoring the quality of drinking water is of paramount importance for public health. Water is not a commercial product but a heritage that must be protected, defended and treated as such (Water Framework Directive 2000/60/EC). The threat of waterborne diseases in Europe will predictably increase in the future as the human population increases and as a result of globalization and migration from non-EU countries and of climate change. Development of efficient, sensitive, robust, rapid and inexpensive tests to monitor various aspects of water quality represents an essential milestone within the strategy for control and prevention of diseases caused by waterborne pathogens and by algal toxins. Traditional methods for the detection of waterborne pathogens, based on cultivation, biochemical characterisation and microscopic detection are laborious and time-consuming; molecular biological tools have now greatly enhanced our ability to investigate biodiversity by identifying species and to estimate gene flow and distribution of species in time and space. µAQUA aims to design and develop a universal microarray chip for the high-throughput detection in water of known and emerging pathogens (bacteria, viruses, protozoa and cyanobacteria) and to assess the water quality monitoring the presence of select bioindicators (i.e. diatoms). A chip able to detect cyanobacterial toxins will also be developed. These innovative molecular tools should be amenable to automation so that they could be deployed on moorings for routine semi-continuous monitoring of water quality. µAQUA also aims to identify cyanophages potentially capable of controlling and mitigating the periodical blooming of toxic cyanobacteria in drinking water reservoirs. Overall, these innovative and cost efficient technologies will reduce energy requirements and improve performance of water treatment, and allow rapid management response to new situations brought about by environmental (including climatic) changes.

This application is based on ruby (-v=1.9.3p547) and rails (-v=3.2.13) framework. It utilizes mysql RDBMS to manage data.

Installation
=============

1. Make sure you have ruby, rails and mysql installed with the defined versions.
2. Clone the repository
3. Move the database.yml file from application root to bioaqua1/config directory.
4. Provide the username and password under the development environment. Make sure to follow the style while write the uasername and password. For example, 'Username{colon}{space}<username>'.
5. check the database name (in development environment) in the database.yml file and create a database with the same name on your locally installed mysql database.
6. run 'rake db:migrate' or 'bundle exec rake db:migrate', just to make sure if the database connection is working fine.
7. Run 'rake db:schema:load' or 'bundle exec rake db:schema:load'.
8. Run 'rake db:seed' or 'bundle exec rake db:seed'.
9. launch the application on http://localhost:3000 and login as partner1 with password p1.
10. If you come across any installation related issue please contact on kumarsaurabh20@gmail.com or post your query on:  https://github.com/kumarsaurabh20/bioaqua1/issues 

OR

for linux users, simply download the install.sh file and execute the file with adminitrative privilages.

sudo ./install.sh
