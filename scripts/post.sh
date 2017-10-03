#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat7/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat7/tomcat-users.xml
service tomcat7 restart

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

# Allow anonymous & authenticated users to view repository objects
drush --root=/var/www/drupal role-add-perm "anonymous user" "view fedora repository objects"
drush --root=/var/www/drupal role-add-perm "authenticated user" "view fedora repository objects"
drush --root=/var/www/drupal cc all

# Lets brand this a bit

cat <<'EOT' >> /home/vagrant/.bashrc
echo ' ap  _aaa   ap       q     qp      qa  aaaap       qaaap    qaaap       a         aaaaaaap               qaa         aaa     qaap       aaaa      _aaaa   qaa/'
echo ' Qf ]Q"-??  Qf      jQb    ]Qbp    dQ  QP???Qbp  yQ?" "?Qg  ]Q??9Qp    jQb        ????4QP               )?4Q        )?4Q   _mP`]4b      QP??QL  qQT!`]?`  ?4Qf'
echo ' Qf )$wap   Qf     aW`4b   ]Q74bp  3Q  Qf    4Q jP       4m ]Q  qQ(   jQ"4b          aQ^      aa .ap      ]Q          ]Q   ]@    Qf     Qf jmP jQ`         ]Qf'
echo ' Qf    "4Qp Qf    ]WgawQb  ]Qf )4Qp3Q  Qf    ]Q 4L .     jQ ]Q4QP`   jQbawQL        yW`        4mQ? qaa   ]Q          ]Q   ]m    Qf     QPQQ`  ]Q,         ]Qf'
echo ' Qf Qb .qQ`.Qf   qQ?????Qb ]Qf   J4QQ  Qf  qw@` )$bp   qyP` ]Q )$w  jW?????Qw     jmP         qy?4b )??   ]Q          ]Q   )Qa  w@`     Qf]4bp  9ga   .p   ]Qf'
echo ' ?`. ????`  ????`?`     ]?`)?`     ]4  ?????`     J?????`   )?   ?? ?`     )?`    ?`      )? )?`:."?      )?    ??    )?     ????       ?`  "?`   ?????`.  )?`'
echo '                                                                            qp r  7   p ar qa ap ap q q qa'
echo '                                                                p   f   ) 4 ][ f ]f ay`aQqby`yQ[aJ aQQQwyQQQ'
echo '                                                  q    aa/ Qa   bp aW yfqf)`.b y ]@]QQ QP Qb)Q?\aQQQQQQWWQQQ)"p'
echo '                                            aWQp  Qbp qQWQpQQQfqyawWQ P\]` QQp4QQQbQQQyQF]QQ?QQQQQQQQQ??4QQQQyfq`ayb'
echo '                           a    qQ    yQf aaWQQP?yQQQa4QQQbyQQP)?????``   yQQ)jf )4?f? f  ` _`Jp??? )^apqa  ?P`Q]QQba 7j`p                              p  ajpqpqpqpbpb7b)a4p`   )?`.'
echo '                    ybp  aQQQ qaQQb QQP??? ?4QP?`.)?`  ?              qaayQ`] qf  ] ]` q  j ]p -    yQ?qQQ  q ..????Q\b]fwf_ p            q .pqpqa9a4p4p? ?)??'
echo 'aaQQ?Qb ap    aa aaWQ? )4QQ?? ??`    )                               QQQWPqJ) /b   \ ( )  )p       y?aP)4Qp)?   )J\. jp])??)`?]jab)a\Jg4aPP `)^? `'
echo 'aaajQP`??  ???`  )??`                                                Q??Q Qf \ )\, )wJp  p       aPaP   ]bf          `. `)  ] q'
echo '     .                                                                yQa7`  `),-4a Jp q      qyP` ?`    4Qp'
echo '                                                                       )???\aaaap )\p"p       ??         .Qbp'
echo '                                                                          4b ??`             aQp           ?wp'
echo '                                                                           Q qy              4Qf           "yQp'
echo '                                                                         ap?`QP               ?b             ??a'
echo '                                                                      ayP?^  4m                Qw              qaa'
echo '                                                                   Jf        .`                )?                ]'
                                                                        `         ````              )                  ` `'
EOT