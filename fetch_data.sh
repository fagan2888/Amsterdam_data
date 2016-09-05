## getting Amsterdam Energy data
curl -O https://www.liander.nl/sites/default/files/Liander_kleinverbruiksgegevens_01012016.zip

unzip Liander_kleinverbruiksgegevens_01012016.zip

#pipe data to postgres
cat Liander_kleinverbruiksgegevens_01012016_v2.csv | iconv -f us-ascii -t utf8 | psql -h postgrespaul3.c2kpbzqmp10d.us-west-2.rds.amazonaws.com -U database_user -d postgresdb3  -c "\copy raw.liander_table FROM '~/Amsterdam_data/data/Liander_kleinverbruiksgegevens_01012016_v2.csv' with csv header;"

#remove zip files. 
rm Liander_kleinverbruiksgegevens_01012016.zip

#get postcode PC4 shape files
curl -O http://www.imergis.nl/shp/ESRI-Openpostcodevlakken_PC4.zip

psql -h postgrespaul3.c2kpbzqmp10d.us-west-2.rds.amazonaws.com -p 5432 -U database_user -W database_password -d postgresdb3

shp2pgsql -I -s 28992:4326 -d  ESRI-PC4-2015R1 geo.postcodes | psql -h postgrespaul3.c2kpbzqmp10d.us-west-2.rds.amazonaws.com -p 5432 -U database_user -W database_password -d postgresdb3

#get postcode PC6 shape files
#  License: CC-BY met vermelding van Esri Nederland, Kadaster
curl -O http://geo-koop.rug.nl/agol/rug/ee6772a214fc4c13b8cd2993516e4417/1.zip

unzip 1.zip

shp2pgsql -I -s 28992:4326 -d  Postalcode_6_areas_Netherlands geo.postcodes_pc6 | psql -h postgrespaul3.c2kpbzqmp10d.us-west-2.rds.amazonaws.com -p 5432 -U database_user -W database_password -d postgresdb3

