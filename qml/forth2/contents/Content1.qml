import QtQuick 2.2

Rectangle {
    width:parent.width
    height:parent.height
    color:"transparent"

    Image
    {
        x: 20
        y: 0
        source:"forthprocess.jpg"

    }


    Image {
        id: image1
        anchors.right:parent.right
        anchors.rightMargin: 20
        y: 10
        source: "register_bg.png"

        AnimatedImage
        {
            fillMode:Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.leftMargin: 100
            source: "panda.gif"
        }
    }



}
