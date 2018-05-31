```yml
Course: Data & Databases
Date: 2018-05-27
Author: Kaspar Manz
```

# 1) Theoretical query

> Come up with a query that you want to make in the mondial database in PostgresSQL--something that might be interesting and challenging. Just describe it in English, and we will look into it on Tuesday. It could be something that you try out and are unable to make work, or it could be something that just sounds interesting to you.

Find mountains, rivers and lakes that belong to several countries (i.e. mark a border). The interesting part would be drawing on a map them and seeing whether the resolution (and amount of items) is high enough to reconstruct the actual borders.

# 2) Read and respond to the following.

> The Library of Babel (Links to an external site.)Links to an external site. by Jorge Luis Borges

> Relational and Non-Relational Models in the Entextualization of Bureaucracy (Links to an external site.)Links to an external site. by Michael Castelle

> The primary challenge when first working with database applications is to retool your mind so you are able to imagine how to see/understand how the database works in the essentially invisible space of computer memory. The Catelle's essay is a practical, historical, and theoretical introduction to the rise of the relational database. The Borges' story from 1934 is often cited along with other works by Borges' (such as "The Garden of Forking Paths") as a prophetic imagining of the Internet. How close was Borges to accurately predict the database? This is an open question, story wasn't trying to predict anything, but instead was imagining a metaphorical space for storing an infinite amount information.

> Read the Borges first, and then, as you read Castelle's essay, search for parts that evoke, align with, and/or contradict passages from Borges. These connections can be as literal or Impressionistic as you want them to be. Find between three and five connections between the two texts and for each connection write a brief paragraph describing how discovered and understand the overlap between the two.

Michael Castelle mentions the importance of indices for the success of the relational database model. It can be a argued that this is the aspect that distinguishes the relational database model to the Borgian library: an index is obviously needed to find data, and in the library, this is missing – or rather, it cannot be found, despite its theoretical existence. This knowledge is what drives the librarians mad – they know that this index must be somewhere, they know it would give them access to all the knowledge that is stored in the library (of which they also know it must be available), but neither is available. They are lost in a sea of data, devoid of information.

As such, the library can be compared to big data, upon which Michael Castelle lightly touches at the end of his article. A lot of companies have suddenly realised that through their extensive record-keeping and tracking of their costumers, they have amassed huge quantities of data and that in there, maybe, "value" might be hidden. The problem is of course that more often than not, this is once again a soup of data, lacking, just like the library, an index to its riches. The only difference is that instead of librarians it is now droves of processors that fish for meaning in seas of data.

A possible reading of the librarians and their actions could be as transactions. By changing or removing books, they are changing the library, in a largely uncontrolled way. This is in stark contrast to the controlled transactions of relational databases, which take great pains in ensuring that these transactions can be traced, logged, and, in the worst case, be reverted. 

It is mentioned that these changes have almost no repercussions in the context of the infinite library, as there are nearly identical copies of every book to be found somewhere else in the library. This is reminiscent of today's handling of relational databases that drive large websites: in order to remain fast and not overwhelm the database with requests of its many users, copies of the database are distributed all over the globe. They all have to be kept in sync with each other, in order to avoid the library scenario: tons of databases with slightly diverging information and no idea which one of them is the "real" one.