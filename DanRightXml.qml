import QtQuick.XmlListModel 2.0

//![1]
XmlListModel {
    // Hard-coded test data
    xml: "<results><row><jingluo>足窍阴</jingluo><posx>1110</posx><posy>384</posy></row>"
        +"<row><jingluo>侠溪</jingluo><posx>1098</posx><posy>395</posy></row>"
        +"<row><jingluo>丘墟外</jingluo><posx>1027</posx><posy>439</posy></row>"
        +"<row><jingluo>阳陵泉</jingluo><posx>809</posx><posy>439</posy></row>"
        +"<row><jingluo>膝阳关</jingluo><posx>766</posx><posy>430</posy></row>"
        +"<row><jingluo>风市</jingluo><posx>710</posx><posy>430</posy></row>"
        +"<row><jingluo>环跳</jingluo><posx>597</posx><posy>430</posy></row>"
        +"<row><jingluo>居髎</jingluo><posx>512</posx><posy>421</posy></row>"
        +"<row><jingluo>五枢</jingluo><posx>490</posx><posy>402</posy></row>"
        +"<row><jingluo>章门下1</jingluo><posx>470</posx><posy>414</posy></row>"
        +"<row><jingluo>章门下</jingluo><posx>446</posx><posy>413</posy></row>"
        +"<row><jingluo>腹哀</jingluo><posx>427</posx><posy>489</posy></row>"
        +"<row><jingluo>承满下</jingluo><posx>399</posx><posy>355</posy></row>"
        +"<row><jingluo>食窦下</jingluo><posx>367</posx><posy>388</posy></row>"
        +"<row><jingluo>渊腋</jingluo><posx>327</posx><posy>422</posy></row>"
        +"<row><jingluo>周荣外</jingluo><posx>279</posx><posy>416</posy></row>"
        +"<row><jingluo>云门外</jingluo><posx>229</posx><posy>422</posy></row>"
        +"<row><jingluo>肩中上</jingluo><posx>218</posx><posy>414</posy></row>"

        +"</results>"
//![2]
    query: "/results/row"

    XmlRole { name: "posx"; query: "posx/string()" }
    XmlRole { name: "posy"; query: "posy/string()" }
    XmlRole { name: "jingluo"; query: "jingluo/string()" }
}
//![2]
