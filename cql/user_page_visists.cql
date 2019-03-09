// Count the number of users visited search page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN count(distinct(r))

// Count the number of users visited home page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'home_page'})
    RETURN count(distinct(r))

// Count the number of users visited checkout page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'checkout_page'})
    RETURN count(distinct(r))

// Count the number of users visited payment confirmation page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN count(distinct(r))

//Gender Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.gender , count(u.gender) AS total

// Device Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.device , count(u.device) AS total
 
// Device and Gender Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.device, u.gender , count(u) AS total ORDER BY count(u) DESC


// Number of user's that visisted both search and home page
MATCH (e1:Entry { page : 'home_page'})<-[r2:VISITED]-(u:User)-[r1:VISITED]->(e2:Entry { page : 'search_page'}) RETURN count(distinct(u))

// Number of user's that visisted both search and home page
MATCH (e1:Entry { page : 'home_page'})<-[r2:VISITED]-(u:User)-[r1:VISITED]->(e2:Entry { page : 'checkout_page'}) RETURN count(distinct(u))

// Number of user's that visisted search or home page and checkout page
MATCH (e1:Entry)<-[r2:VISITED]-(u:User)-[r1:VISITED]->(e2:Entry)
WHERE (e1.page = 'home_page' OR e1.page = 'search_page') AND e2.page = 'checkout_page'
RETURN u

// Number of users who vsisted home page and checkout page
MATCH (e1:Entry)<-[r2:VISITED]-(u:User)-[r1:VISITED]->(e2:Entry)
WHERE e1.page = 'home_page' AND e2.page <> 'checkout_page'
RETURN count(u)

// Number of users who visited checkout page but not payment confirmation page
MATCH (u:User)-[:VISITED]->(:Entry { page : 'checkout_page'})
WHERE NOT (u)-[:VISITED]->(:Entry { page : 'payment_confirmation_page'})
RETURN count(u)


// Grouping page visit's based on different attributes
// 1. Page
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN e.page as page, count(u) as total_users

// 2. Gender
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN u.gender as gender, count(u) as total_users

// 3. Gender and page
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN u.gender as gender, e.page as page, count(u) as total_users

// 4. Page and device
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN e.page as page, u.device  as platform , count(u) as total_users

// 5. Page and location
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN e.page as page, r.state as state, r.country as country, count(u) as total_users ORDER BY count(u) DESC

// 6. Location wise visits
MATCH (u:User)-[r:VISITED]->(e:Entry)
    RETURN r.state as state, r.country as country, count(u) as total_users
