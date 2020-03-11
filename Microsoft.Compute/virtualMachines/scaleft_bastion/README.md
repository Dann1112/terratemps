#Manual ScaleFT Bastion Creation

This plan allows for the creation for the manual creation of a ScaleFT bastion in an existing environment.

This can prove useful in certain situations:
 - A particular DNS server needs to be specific that differs from the default applied to the Virtual Network.
 - Automation is matching an incorrect subnet which happens to have "BAS" in its name during creation.
 - A different SKU size is required rather than the default Standard A1v2.
 - Setting the scope of the bastion during deployment rather than after automation.
 - You're too impatient to wait for automation to run and create the bastion.

variables.tf contains further details on required information for each variable.

NOTE: A random 48 character password will be created for the admin user and you will not be able to obtain this password again using password-grabber.json. You also cannot reset the password unless you are already on the server itself as the Azure Agent is disabled as part of hardening.