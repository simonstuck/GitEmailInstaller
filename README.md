GitEmailInstaller
=================

Small script that enables email notifications in for git repositories.

For help run the script with the -h flag.

This script is only guaranteed to work on newly initialised repositories (at the moment) and may break configuration files if called multiple times. 

This is because the relevant commands are simply appended to the file and do not consider the existing contents of the file. The script is intended as a small helper script and it should therefore not matter. 

I may upgrade the script in the future to support some more sophisticated parsing.
