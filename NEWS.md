# EMODnetWFS 2.0.0


* NEW FEATURE: Added `ecql` filtering capability and ability to interrogate feature attribute (see relevant vignette).
* Bug fix: corrected service namespace definition when using a `wfs` object
* Breaking Change: set to extract default CRS from service information (through `getDeafultCRS` method)
* Breaking change: Removed default service value.
* Updated to new EMODnet Seabed Habitats endpoints
* Added a `NEWS.md` file to track changes to the package.