
// Count the number of users visited search page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN count(distinct(r))

// Count the number of users visited home page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'home_page'})
    RETURN count(distinct(r))

// Count the number of users visited home page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_page'})
    RETURN count(distinct(r))

// Count the number of users visited payment confirmation page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN count(distinct(r))

// Returns distinct user's list who visited payment confirmation page
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN distinct(u) limit 1


// List user's who visited search page as well as home page 
MATCH (e1:Entry {page : 'search_page'})<-[r1:VISITED]-(u:User)-[r2:VISITED]->(e2:Entry { page : 'home_page'}) RETURN u

// Group User's based on different properties for different page visits ::

// 1. Search Page : 

// 1.1. Gender Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.gender , count(u.gender) AS total

// 1.2. Device Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.device , count(u.device) AS total
 
// 1.3. Device and Gender Grouping
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'search_page'})
    RETURN u.device, u.gender , count(u) AS total ORDER BY count(u) DESC
 

// Payment Page 

// Return user's
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN u 

// Grouping user's basd on gender and device
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN u.gender as gender , u.device as device , count(u) as total ORDER BY count(u) DESC