:' 
select \
id, \
hp, \
name, \
upgHP, \
score, \
doubleBulletSize, \
doubleFireSpeed, \
quadrupleFireSpeed, \
quadrupleBullets, \
dualBullets \
from playerstream emit changes;