# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

## Command 
- Add additional libraries to the **package.json** file for the communication with external systems: `npm add @sap-cloud-sdk/http-client@3.x @sap-cloud-sdk/util@3.x @sap-cloud-sdk/connectivity@3.x @sap-cloud-sdk/resilience@3.x`
- Upload an edmx file to the project's root and import it: `cds import OP_API_BUSINESS_PARTNER_SRV.edmx --as cds`

## Q&A

**Q:** What should I do if I fail to upload edmx file?

**A:** Open vscode settings and edit, search **editor.maxTokenizationLineLength**, and change the **Max Tokenization Line Length**.