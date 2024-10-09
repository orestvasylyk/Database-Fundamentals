# Subtaks for topic 08. SQL DDL

Table "Countries" {
  "countryid" SERIAL [pk, increment]
  "countryname" VARCHAR(100) [not null]
}

Table "Regions" {
  "regionid" SERIAL [pk, increment]
  "regionname" VARCHAR(100) [not null]
  "countryid" INT
}

Table "Clients" {
  "clientid" SERIAL [pk, increment]
  "name" VARCHAR(100) [not null]
  "numberofpeople" INT [not null]
  "passportdata" VARCHAR(50) [not null]
  "phone" VARCHAR(15)
  "email" VARCHAR [not null]
  "countryid" INT
  "regionid" INT
}

Table "Agents" {
  "agentid" SERIAL [pk, increment]
  "fullname" VARCHAR(100) [not null]
  "commissionrate" DECIMAL(5,2) [not null]
}

Table "Orders" {
  "orderid" SERIAL [pk, increment]
  "clientid" INT
  "orderdate" DATE [not null]
  "totalamount" DECIMAL(10,2)
  "orderstatus" VARCHAR(50)
}

Table "Orderlines" {
  "orderlineid" SERIAL [pk, increment]
  "orderid" INT
  "itemtype" VARCHAR(50)
  "quantity" INT
  "unitprice" DECIMAL(10,2)
  "subtotal" DECIMAL(10,2)
}

Table "Rooms" {
  "roomnumber" INT [pk]
  "numberofbeds" INT
  "roomtype" VARCHAR(50)
  "costperday" DECIMAL(10,2)
}

Table "CarModels" {
  "carmodelid" SERIAL [pk, increment]
  "manufacturer" VARCHAR(50)
  "brand" VARCHAR(50)
  "cartype" VARCHAR(50)
  "costperday" DECIMAL(10,2)
}

Table "Cars" {
  "carnumber" INT [pk]
  "carmodelid" INT
  "color" VARCHAR(50)
}

Table "Bookings" {
  "bookingid" SERIAL [pk, increment]
  "orderlineid" INT
  "roomnumber" INT
  "checkindatetime" TIMESTAMP
  "checkoutdatetime" TIMESTAMP
}

Table "RentalAgreements" {
  "agreementid" SERIAL [pk, increment]
  "orderlineid" INT
  "carnumber" INT
  "rentalstartdate" DATE
  "rentalenddate" DATE
}

Table "InsuranceContracts" {
  "insurancecontractid" SERIAL [pk, increment]
  "orderlineid" INT
  "agentid" INT
  "insuranceamount" DECIMAL(10,2)
  "premium" DECIMAL(10,2)
  "signingdate" DATE
  "expirydate" DATE
  "cost" DECIMAL(10,2)
}

Ref:"Countries"."countryid" < "Regions"."countryid"

Ref:"Countries"."countryid" < "Clients"."countryid"

Ref:"Regions"."regionid" < "Clients"."regionid"

Ref:"Clients"."clientid" < "Orders"."clientid"

Ref:"Orders"."orderid" < "Orderlines"."orderid"

Ref:"CarModels"."carmodelid" < "Cars"."carmodelid"

Ref:"Orderlines"."orderlineid" < "Bookings"."orderlineid"

Ref:"Rooms"."roomnumber" < "Bookings"."roomnumber"

Ref:"Orderlines"."orderlineid" < "RentalAgreements"."orderlineid"

Ref:"Cars"."carnumber" < "RentalAgreements"."carnumber"

Ref:"Orderlines"."orderlineid" < "InsuranceContracts"."orderlineid"

Ref:"Agents"."agentid" < "InsuranceContracts"."agentid"
