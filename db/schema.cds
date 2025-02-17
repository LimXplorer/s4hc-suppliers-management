namespace sap.ext.BusinessPartner;

using {OP_API_BUSINESS_PARTNER_SRV as bupa} from '../srv/external/OP_API_BUSINESS_PARTNER_SRV';
using {OP_PURCHASEORDER_0001 as purOrd} from '../srv/external/OP_PURCHASEORDER_0001';
using {OP_API_SUPPLIERINVOICE_PROCESS_SRV as suplrInvc} from '../srv/external/OP_API_SUPPLIERINVOICE_PROCESS_SRV';

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

entity ExtSupplier : cuid, managed {
    supplierStatus    : Association to SupplierStatus default 'N';
    operationalStatus : Association to OperationalStatus default 'O';
    taxCategory       : String;
    registeredCapital : Decimal(16, 2);
    supplier          : Composition of Supplier;
    createdAt         : DateTime  @cds.on.insert: $now;
    modifiedAt        : DateTime  @cds.on.insert: $now  @cds.on.update: $now;
}

entity Supplier               as
    projection on bupa.A_BusinessPartner {
        key BusinessPartner               as ID,
            BusinessPartnerFullName       as fullName,
            BusinessPartnerBirthplaceName as birthplace,
            BusinessPartnerIsBlocked      as isBlocked,
            to_BusinessPartnerAddress     as addresses,
            Supplier                      as supplierDetailID,
            to_Supplier                   as supplierDetail,
            purchaseOrders : Association to many PurchaseOrder on purchaseOrders.supplierID = ID
    }

entity PurchaseOrder          as
    projection on purOrd.PurchaseOrder {
        PurchaseOrder as ID,
        Supplier      as supplierID,
        supplier         : Association to Supplier on supplier.ID = supplierID,
        supplierInvoices : Association to many SuplrInvcItemPurOrdRef on supplierInvoices.purchaseOrderID = ID
    }

entity SupplierInvoice        as
    projection on suplrInvc.A_SupplierInvoice {
        SupplierInvoice           as ID,
        to_SuplrInvcItemPurOrdRef as suplrInvcItemPurOrdRef,
        purchaseOrders : Association to many SuplrInvcItemPurOrdRef on purchaseOrders.supplierInvoiceID = ID
    }

entity SuplrInvcItemPurOrdRef as
    projection on suplrInvc.A_SuplrInvcItemPurOrdRef {
        SupplierInvoice as supplierInvoiceID,
        PurchaseOrder   as purchaseOrderID,
        purchaseOrder   : Association to PurchaseOrder on purchaseOrder.ID = purchaseOrderID,
        supplierInvoice : Association to SupplierInvoice on supplierInvoice.ID = supplierInvoiceID
    }

entity SupplierAddresses      as
    projection on bupa.A_BusinessPartnerAddress {
        BusinessPartner as bupaID,
        AddressID       as ID,
        County          as county,
        CityName        as city,
        StreetName      as street,
        to_EmailAddress as emails,
        to_PhoneNumber  as phones,
    }

entity EmailAddress           as
    projection on bupa.A_AddressEmailAddress {
        key AddressID    as addressId,
            EmailAddress as email
    }

entity PhoneNumber            as
    projection on bupa.A_AddressPhoneNumber {
        key AddressID   as addressId,
            PhoneNumber as phone
    }

entity SupplierDetail         as
    projection on bupa.A_Supplier {
        Supplier                 as ID,
        to_SupplierCompany       as companies,
        to_SupplierPurchasingOrg as purchasingOrgs,
    }

entity SupplierCompany        as
    projection on bupa.A_SupplierCompany {
        Supplier    as supplierID,
        CompanyCode as companyCode,
    }

entity SupplierPurchasingOrg  as
    projection on bupa.A_SupplierPurchasingOrg {
        Supplier               as supplierID,
        PurchasingOrganization as ID
    }

entity SupplierStatus : CodeList {
    key code        : String enum {
            New       = 'N';
            Delivered = 'D';
        };
        criticality : Integer;
}


entity OperationalStatus : CodeList {
    key code        : String enum {
            OPERATING  = 'O';
            LIQUIDATED = 'L';
            MERGED     = 'M';
        };
        criticality : Integer;
}
