# NoSQL Database Analysis for FlexiMart

## Section A: Limitations of RDBMS (≈150 words)

The current relational database design faces limitations when managing a highly diverse product catalog. In an RDBMS, all products must conform to a fixed table schema. This becomes inefficient when products have different attributes, such as laptops requiring RAM and processor details while shoes require size and color. Supporting such variability often results in many nullable columns or multiple subtype tables, increasing complexity.

Frequent schema changes are another challenge. Each time a new product type is introduced, ALTER TABLE operations are required, which are costly, time-consuming, and risky in production environments. This reduces agility when business requirements evolve rapidly.

Additionally, storing customer reviews in a relational database requires separate tables with foreign key relationships. Fetching a product along with its reviews involves multiple joins, increasing query complexity and degrading performance, especially as the volume of reviews grows. These limitations make traditional RDBMS less suitable for dynamic, content-rich product catalogs.

---

## Section B: NoSQL Benefits (≈150 words)

MongoDB addresses these challenges through its flexible, document-oriented data model. Each product is stored as a JSON-like document, allowing different products to have different attributes without enforcing a rigid schema. This makes it easy to store laptops, shoes, and future product types in the same collection while preserving their unique characteristics.

Embedded documents are another key advantage. Customer reviews can be stored directly inside the product document as an array. This improves read performance by eliminating joins and allows products and their reviews to be retrieved in a single query.

MongoDB also supports horizontal scalability through sharding. As FlexiMart’s product catalog and traffic grow, data can be distributed across multiple servers, ensuring high availability and performance. Together, schema flexibility, embedded data, and scalability make MongoDB well-suited for managing diverse and evolving product data.

---

## Section C: Trade-offs (≈100 words)

Despite its advantages, MongoDB has trade-offs compared to MySQL. First, MongoDB provides weaker support for complex multi-document transactions, which can be critical in financial or inventory-sensitive applications. Although transactions are supported, they are generally less efficient than in relational databases.

Second, enforcing strict data integrity is more challenging. Without a fixed schema and strong constraints like foreign keys, maintaining consistency relies more on application-level validation. This increases development responsibility and the risk of inconsistent data if validation is not handled carefully.

Section C: Trade-offs (≈100 words)

One disadvantage of MongoDB is the lack of strong transactional guarantees compared to MySQL, especially for complex multi-document transactions. This can be a challenge for financial operations requiring strict consistency. Another drawback is data redundancy due to embedded documents, which can increase storage requirements and complicate updates when shared information changes. Therefore, MongoDB is best suited for flexible catalogs, while relational databases remain preferable for transactional systems like orders and payments.
