// List user's who are Male
MATCH (u:User { gender : 'Male'}) RETURN u

// List user's who are Female
MATCH (u:User { gender : 'Female'}) RETURN u

// List User's who are `Male` and used `mobile` device
MATCH (u:User { gender : 'Male', platform : 'Mobile'}) RETURN u

// Total count of User's who are `Male` and used `mobile` platform
MATCH (u:User { gender : 'Male', platform : 'Mobile'}) RETURN count(u)

// Group user's by gender and take it's count
MATCH (u:User) RETURN u.gender AS gender, count(u) AS total

// Group user's by device and take it's count
MATCH (u:User) RETURN u.device AS device, u.gender as gender, count(u) AS total ORDER BY count(u) DESC

// List the users based on the total amount spent 
MATCH (u:User) RETURN u.id , u.total_amount as total_amount_spent ORDER BY u.total_amount DESC

// Total amount spent based on gender
MATCH (u:User) RETURN  u.gender as gender , SUM(u.total_amount) as total_amount_spent

// Total amount spent based on gender
MATCH (u:User) RETURN  u.gender as gender , SUM(u.total_amount) as total_amount_spent

// Average amount spent by any individual based on gender
MATCH (u:User) RETURN  u.gender as gender , AVG(u.total_amount) as total_amount_spent