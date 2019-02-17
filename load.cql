
// Assert that the USER nodes are unique by it's ID
CREATE CONSTRAINT ON (u:User) ASSERT c.user_id IS UNIQUE;

// Assert that the ENTRY nodes are unique by it's page name
CREATE CONSTRAINT ON (e:Entry) ASSERT e.page IS UNIQUE;

// LOAD user data
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///ecommerce-funnel-analysis/user_table.csv' AS line
WITH DISTINCT line , datetime(line.`date`).epochMillis as date

CREATE (u:User { id: toInteger(line.`user_id`) })
SET u.date = toInteger(date),
    u.device = line.`device`,
    u.gender = line.`sex`

// create search node 
CREATE (e:Entry { page : 'search_page'})

// Load search page entry and create relationships 
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///ecommerce-funnel-analysis/search_page_table.csv' AS line
WITH DISTINCT line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'search_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1


// create payment node 
CREATE (e:Entry { page : 'payment_page'})

// Create user and payment page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///ecommerce-funnel-analysis/payment_page_table.csv' AS line
WITH DISTINCT line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'payment_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1


// create home node 
CREATE (e:Entry { page : 'home_page'})

// Create user and payment page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///ecommerce-funnel-analysis/home_page_table.csv' AS line
WITH DISTINCT line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'home_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1


// create payment confirmation node 
CREATE (e:Entry { page : 'payment_confirmation_page'})

// Create user and payment ocnfirmation page relationship
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM 'file:///ecommerce-funnel-analysis/payment_confirmation_table.csv' AS line
WITH DISTINCT line

MATCH (u:User { id : toInteger(line.`user_id`)}), (e:Entry { page : 'payement_confirmation_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1

