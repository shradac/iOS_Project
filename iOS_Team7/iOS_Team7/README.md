#  Data Model for chat app



## Users Collection
 
 - user1 : 
    - displayName
    - email
    - profilePic
 - user2 : 
    - displayName
    - email
    - profilePic


## Chats Collection

 - participants : [ uid1 , uid2]
 - lastMsg : ''
 - lastMsgTimestamp : <timestamp>
 - messages : 
   - id: mid1
     content: 'sample message1' 
     senderId: uid2
     timestamp: <timstamp>
   - id: mid2
     content: 'sample message2' 
     senderId: uid1
     timestamp: <timstamp>   
