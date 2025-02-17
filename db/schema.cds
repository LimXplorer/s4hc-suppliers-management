namespace sap.ext.suppliers;
using { OP_API_BUSINESS_PARTNER_SRV as bupa } from '../srv/external/OP_API_BUSINESS_PARTNER_SRV';

entity Suppliers as projection on bupa.A_BusinessPartner {
    key BusinessPartner as ID,
    BusinessPartnerFullName as fullName,
    BusinessPartnerIsBlocked as isBlocked,
    to_BusinessPartnerAddress as addresses,
}

entity SupplierAddresses as projection on bupa.A_BusinessPartnerAddress {
    BusinessPartner as bupaID,
    AddressID as ID,
    CityName as city,
    StreetName as street,
    County as county,
    to_EmailAddress as emails,
    to_PhoneNumber as phones,
}

entity EmailAddress as projection on bupa.A_AddressEmailAddress {
    key AddressID as addressId,
    EmailAddress as email
}

entity PhoneNumber as projection on bupa.A_AddressPhoneNumber {
    key AddressID as addressId,
    PhoneNumber as phone
}

