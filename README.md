"# Land-Registry Database" 

This database is a schema of a Land Registry database, able to obtain and handle user records, land parcels, their history, enquiries before transfer with their notifications, various transfer methods, transaction details for sales, land-zoning data, surveys, and audit logs.

Relationships:
A user has a unique platform identification code.
One land owner can  own many land parcels but a parcel can only have one owner.
One buyer can make many enquiries but can only make one enquiry about  specific parcel at a given point.
One enquiry can have multiple notifications. A notification belongs to one specific enquiry.
One parcel can have multiple entries in its history.
One parcel can have many transfers, but only one transfer at a time.
There can be many transactions for one parcel, but only one transaction at a given point.
A parcel has only one zoning status.
One parcel can undergo multiple surveys.
One record can have multiple logs of changes.

Indexes created include those on the:
    user ID
    land Owner ID 
    buyer status
    land IDs

