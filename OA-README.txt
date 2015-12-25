OpenAIRE Compliance
===================

Version: 0.3 (Beta)
EPrints version: 3.2+

This EPrints extension is designed to help the administrators of repositories that contain outputs from EU FP7 funded projects to achieve compliance with the OpenAIRE Guidelines version 1.1 (http://www.openaire.eu/index.php?option=com_content&view=article&id=207).

In summary, these guidelines state that the outputs from FP7 projects must be made avaiable for harvesting via OAI-PMH using a defined set specification. In addition these outputs should meet certain standards in their metadata as defined in 
the guidelines document.

For installation instructions see the included document INSTALLATION.txt


What this add-on does and doesn't do
------------------------------------

This add-on will:

* Add new metadata fields for EU FP7 specific elements
* Map the default EPrints data types to their DRIVER equivalents (see http://www.driver-support.eu/documents/DRIVER_Guidelines_v2_Final_2008-11-13.pdf, page 69)
* Create a new custom set within the OAI-PMH output of the repository called EC_fundedresources and containing all resources that are flagged as being outputs of FP7 projects
* Add required metadata to the OAI-PMH output
* Check if any files have an embargo date specified (and are restricted access) and alter the rights field in OAI-PMH output to reflect this


This add-on will not:

* Check whether items flagged as outputs of FP7 projects have a Project ID specified in the correct format before including them in the EC_fundedresources set
* Check whether items flagged as outputs of FP7 projects have full text available before including them in the EC_fundedresources set
* Check whether items flagged as outputs of FP7 projects have all required metadata set (e.g. DC.rights)

This is due to the fact that EPrints custom sets can only currently filter on a single metadata value (in this case we're using the flag that states that the resource is form an FP7 funded project).
