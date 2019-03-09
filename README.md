# Neo4j funnel analysis

This Neo4j based project does a funnel analysis for a E-Commerce website. It is designed to serve as a template for further development projects.  Feel encouraged to fork and update this repo!

## Data Model

![enter image description here](https://i.imgur.com/rnFNiIH.png)

### Nodes with properties 

* `User { id: string, timestamp: timestamp, device: string, gender: string }`
* `Entry { page: string}`

### Relationships with properties

* `(:User)-[:VISITED {count: string}]->(:Page)`


## Users and Pages

### Load some fake data 

If you're running the app locally, you might want to tweak without having a robust community of users.
In the `/datasets` directory, note that there are files named  `users.csv, search.csv, home.csv, checkout.csv, payment_confirm.csv`.
These files contains some pseudo-randomly generated values.

Move `users.csv` into the `import` directory of your database either by dragging and dropping or using

Set your  `NEO4J_HOME`  variable:  
```bash 
export NEO4J_HOME=/path/to/neo4j-community
``` 
Copy files : 
 ```bash 
 cp datasets/users.csv $NEO4J_HOME/import/users.csv
 ```
 Copy every file contained in the `datasets` directory by the above command 
 
Assuming your database is running, paste the following queries into the Neo4j browser:

```
// Assert that the USER nodes are unique by it's ID
CREATE CONSTRAINT ON (u:User) ASSERT u.user_id IS UNIQUE;

// Assert that the ENTRY nodes are unique by it's page name
CREATE CONSTRAINT ON (e:Entry) ASSERT e.page IS UNIQUE;
``` 
```
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///your/location/user.csv' AS line
WITH DISTINCT line , datetime(line.`date`).epochMillis as date

CREATE (u:User { id: toInteger(line.`user_id`) })
SET u.date = toInteger(date),
    u.device = line.`device`,
    u.gender = line.`gender`
```
```
// Create page node with diffrent page properties 
CREATE (:Entry { page : 'search_page'})
CREATE (:Entry { page : 'checkout_page'})
CREATE (:Entry { page : 'home_page'})
CREATE (:Entry { page : 'payment_confirmation_page'})
```
```
// Load search page entry and create relationships 
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///search.csv' AS line
WITH line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'search_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1
```
```
// Create user and checkout page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///checkout.csv' AS line
WITH line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'checkout_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1
```
```
// Create user and home page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///home.csv' AS line
WITH DISTINCT line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'home_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1
```

```
// Create user and payment confirmation page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///payment_confirm.csv' AS line
WITH line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'payment_confirmation_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1
```


***Finally the graph looks like this:***
![enter image description here](https://i.ibb.co/LRNY91P/funnel-crop.png)
