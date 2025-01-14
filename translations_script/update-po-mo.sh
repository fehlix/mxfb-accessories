#!/bin/bash

#make po files

RESOURCE="mxfb-accessories"

lang="am ar bg ca cs da de el es et eu fa fi fr fr_BE he_IL hi hr hu id is it ja kk ko lt mk mr nb nl pl pt pt_BR ro ru sk sl sq sr sv tr uk zh_CN zh_TW"

make_po()
{
for val in $lang; do
    if [ ! -e "po/$val/$RESOURCE.po" ]; then
        mkdir -p po/$val
        msginit --input=pot/"$RESOURCE".pot --no-translator --locale=$val --output=po/$val/"$RESOURCE".po
    else
        msgmerge --update po/$val/$RESOURCE.po pot/$RESOURCE.pot
    fi
done
}

make_pot()
{
if [ ! -d "pot" ]; then
    mkdir pot
fi
xgettext --language Shell  --add-comments --sort-output -o pot/$RESOURCE.pot ../mxfb-menu-generator ../mxfb-tint2-manager ../mxfb-trashcheck ../mxfb-bg-rotate ../mxfb-borders ../mxfb-font ../mxfb-quickshot ../mxfb-separate-backgrounds ../mxfb-tiles ../mxfb-timer ../mxfb-top ../mxfb-look ../exit-options-manager
}

make_mo()
{
    for val in $lang; do
        if [ ! -e "mo/$val/$RESOURCE.mo" ]; then
            mkdir -p mo/$val
            msgfmt --output-file=mo/$val/"$RESOURCE".mo po/"${RESOURCE}_${val}.po"
        fi
    done
}

po()
{
    make_pot
    make_po
}

mo()
{
    make_mo
}

pot() 
{
	make_pot
}

main()
{
    $1 
    $2
}

main "$@"


