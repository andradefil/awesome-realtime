:' 
select \
rowKey, \
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
from playertable emit changes;