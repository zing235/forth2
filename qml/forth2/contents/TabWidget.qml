import QtQuick 2.2
import QtQuick.Controls 1.1
import Camera1394 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
Rectangle
{
    id: tabwidget
    color: "transparent"

    function currentChanged(curIndex)//切换table
    {
        content.currentChangedzz(curIndex)
    }

    Row
    {
        id: toolbar
        spacing: 12
        anchors.left: tabwidget.left
        anchors.leftMargin: 10
        property int current: 0
        onCurrentChanged:setCurrentToolBtn()

        function setCurrentToolBtn()//切换table
        {
            for(var i = 0; i < toolbar.children.length; i++)
            {
                toolbar.children[i].state = (toolbar.current == i ? 'checked' : 'leave')
            }
            tabwidget.currentChanged(toolbar.current)
        }

        ToolBtn
        {
            index:0
            state:"checked"
            picSrc: "ico_Examine.png"
            btnText:"浮选流程"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:1
            picSrc: "ico_dsmain.png"
            btnText:"主界面"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:2
            picSrc: "ico_SysRepair.png"
            btnText:"金粗选"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:3
            picSrc: "ico_TraceCleaner.png"
            btnText:"金特征"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:4
            picSrc: "ico_SpeedupOpt.png"
            btnText:"锑粗选"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:5
            picSrc: "ico_expert.png"
            btnText:"锑特征"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:6
            picSrc: "ico_diannaomenzhen.png"
            btnText:"金加药"
            onClicked:toolbar.current=btnIndex
        }
        ToolBtn
        {
            index:7
            picSrc: "ico_softmgr.png"
            btnText:"锑加药"
            onClicked:toolbar.current=btnIndex
        }
    }

    Rectangle
    {
        id:content
        width:tabwidget.width
        anchors.top: toolbar.bottom
        anchors.topMargin: -5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        color:"white"

        property int current: 0
        function currentChangedzz(curIndex)
        {
            content.children[curIndex].x=width
            content.children[curIndex].state='active'
            content.children[current].state='hide'
            current = curIndex
        }

        MainWidget
        {
            id:widget1
            state:"active"

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
                    MouseArea{
                          anchors.fill: parent
                          hoverEnabled :true
                          onClicked:  {
                              loginwindow.visible=true
                          }
                      }

                    AnimatedImage
                    {
                        id: pada
                        fillMode:Image.PreserveAspectFit
                        anchors.right: parent.right
                        anchors.leftMargin: 20
                        source: "panda.gif"
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        id: denglu
                        text: "点我登录"
                        font.pixelSize: 25
                    }
                    Window{
                        id:loginwindow
                        width: 320
                        height: 240
                        color: "#215400"
                        visible: false
                        Rectangle{
                            anchors.fill: parent
                            color: "#1d4d62"
                            radius: 10
                            border.color: "#000000"
                            border.width: 2

                            Rectangle {
                                id: rectangle1
                                x: 0
                                y: 1
                                width: 320
                                height: 42
                                color: "#c8c7c7"
                                radius: 9
                                border.width: 3
                                border.color: "#000000"

                                Text {
                                    id: text1
                                    x: 15
                                    y: 8
                                    width: 234
                                    height: 26
                                    text: "新龙矿业泡沫浮选系统"

                                    font.bold: true

                                    font.pixelSize: 26
                                }
                            }

                            Rectangle {
                                id: rectangle2
                                x: 8
                                y: 70
                                width: 304
                                height: 35
                                color: "#ffffff"
                                radius: 0
                                TextField {
                                    id:textname
                                    placeholderText: "请输入用户名"
                                    Layout.fillWidth: true
                                    anchors.fill: parent
                                    font.pixelSize: 35

                                }
                               }

                            Rectangle {
                                id: rectangle3
                                x: 8
                                y: 120
                                width: 304
                                height: 35
                                color: "#ffffff"
                                TextField {
                                    id:textpassword
                                    placeholderText: "请输入密码"
                                    Layout.fillWidth: true
                                    anchors.fill: parent
                                    font.pixelSize: 35
                                    echoMode: TextInput.Password
                                }
                            }

                            Button {
                                id: loginbutton
                                x: 8
                                y: 189
                                width: 304
                                height: 43
                                text: "登录"
                                onClicked: testid1()
                                function testid1()
                                {
                                    if(textname.text=="csu"&&textpassword.text=="xks")
                                    {
                                        widget2.visible=true
                                        widget3.visible=true
                                        widget4.visible=true
                                        widget5.visible=true
                                        widget6.visible=true
                                        widget7.visible=true
                                        widget8.visible=true
                                        loginresult.title="登陆成功"
                                        loginresult.text="欢迎使用新龙矿业浮选系统"
                                        loginresult.visible=true
                                        loginwindow.visible=false
                                        denglu.text="成功登录"
                                    }
                                    else{
                                        loginresult.title="登陆失败"
                                        loginresult.text="请重新登录"
                                        loginresult.visible=true
                                    }
                                }
                            }
                            MessageDialog{
                                id:loginresult
                                visible: false

                            }

                        }
                        }
                }
            }
        }
        MainWidget
        {
            id:widget2
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 20
                color:"#99FF0000"
                Column{
                    anchors.fill: parent
                    spacing: 30
                    Rectangle{
                        width: parent.width/2
                        height: parent.height/2-15
                        color:"red"
                        Camera1394 {
                          anchors.fill: parent
                          id: camera1394test11
  //                        renderTarget: FramebufferObject
                          Timer{
                              id: cameratimer11
                              interval: 50;
                              repeat: true
                              onTriggered: {
                                  time11.text = Date().toString()
                                  camera1394test11.updatecamera()
                              }
                          }
                          Timer{
                              id: valuetimer11
                              interval: 30000;
                              repeat: true
                              onTriggered: {
                                  imagevalue.getImageValue();
                              }
                          }
                          Button {
                              id: button11
                              text: "StartCamera"
                              iconSource: qsTr("")
                              activeFocusOnPress: false
                              checked: false
                              anchors.left: parent.left
                              anchors.leftMargin: 0
                              anchors.top: parent.top
                              anchors.topMargin: 0
                              onClicked:{
                                  camera1394test11.startcamera()
                                  cameratimer11.start()
                                  valuetimer11.start()
                              }

                          }
                          Text {
                              id: time11
                              text: "time"
                              anchors.right: parent.right
                              anchors.rightMargin: 0
                              anchors.top: parent.top
                              anchors.topMargin: 0
                              style: Text.Raised
                              font.pointSize: 15
                          }
                         }

                    }
                    Rectangle{
                        width: parent.width/2
                        height: parent.height/2-15
                        color: "blue"

                    }
                }

            }
        }
        MainWidget
        {
            id:widget3
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#00000000"
                Rectangle{
                     id:aucamera
                     anchors.fill: parent
                     anchors.rightMargin: 300
                     color:"#707070"
                      Camera1394 {
                        anchors.fill: parent
                        id: camera1394test
//                        renderTarget: FramebufferObject
                        Timer{
                            id: cameratimer
                            interval: 50;
                            repeat: true
                            onTriggered: {
                                time.text = Date().toString()
                                camera1394test.updatecamera()
                            }
                        }
                        Timer{
                            id: valuetimer
                            interval: 30000;
                            repeat: true
                            onTriggered: {
                                imagevalue.getImageValue();
                            }
                        }
                        Button {
                            id: button1
                            text: "StartCamera"
                            iconSource: qsTr("")
                            activeFocusOnPress: false
                            checked: false
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            onClicked:{
                                camera1394test.startcamera()
                                cameratimer.start()
                                valuetimer.start()
                            }

                        }
                        Text {
                            id: time
                            text: "time"
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            style: Text.Raised
                            font.pointSize: 15
                        }
                       }
                }
                Rectangle{
                    id:aucharacter
                    anchors.top:parent.top
                    anchors.left: aucamera.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    color: "gray"
                    Rectangle{
                        anchors.fill: parent
                    Column{
                        anchors.top: parent.top
                        id:pinweiyuce
                        width: parent.width
                        height: 195
                        spacing: 5



                    Rectangle{
                        width: parent.width
                        height: 45
                        color: "#000000"
                       Text{
                            id:pinwei
                            anchors.centerIn: parent
                            text: "原矿品位预测"
                            font.pixelSize:40
                            font.italic: true
                            color: "#00FFFF"
                        }
                    }
                    Row{
                        width: parent.width
                        spacing: 6

                    Rectangle{
                        width: parent.width/2-13
                        height: 145
                        color: "#000000"
                       Text{
                            id:pinwei2
                            anchors.centerIn: parent
                            text: "极高"
                            font.pixelSize:50
                            font.italic: true
                            color: "#00FF00"
//                          elide: Text.ElideMiddle

                        }
                    }
                    Rectangle{
                        width: parent.width/2+7
                        height: 145
                        color: "#000000"
                        ListModel {
                            id: dummyModel
                            Component.onCompleted: {
                                append({"编号": 1, "名称": "极低 " , "品位范围" :"0~1"})
                                append({"编号": 2, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 3, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 4, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 5, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 6, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 7, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 8, "名称": "A title " , "品位范围" :"0~1"})
                                append({"编号": 9, "名称": "A title " , "品位范围" :"0~1"})
                            }
                        }
                        TableView{
                            model: dummyModel
                            anchors.fill: parent
                            TableViewColumn {
                                role: "编号"
                                title: "#"
                                width: 30
//                                resizable: false
//                                movable: false
                            }
                            TableViewColumn {
                                role: "名称"
                                title: "名称"
                                width: 50
                            }
                            TableViewColumn {
                                role: "品位范围"
                                title: "品位范围"
                                width: 60

                            }
                        }

                    }
                    }

}
                    Rectangle{

                        anchors.top:pinweiyuce.bottom
                        width: parent.width
                        height:18
                        color: "#009090"
                    }
                    Column{
                        anchors.top: pinweiyuce.bottom
                        anchors.topMargin: 15
                        anchors.bottom: parent.bottom
                        width: parent.width
                        spacing: 5

                    Rectangle{

                        width: parent.width
                        height: 45
                        color: "#000000"
                       Text{
                            anchors.centerIn: parent
                            text: "泡沫特征"
                            font.pixelSize:40
                            font.italic: true
                            color: "#00FFFF"
                        }
                    }
                    Rectangle{
                        id:tezheng1
                        width: parent.width
                        height: (parent.height-75)/6
                        color: "#000000"
                       Text{
                            id:bubblesize
                            anchors.centerIn: parent
                            text: "泡沫大小: " +imagevalue.BubbleSize
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: tezheng1.height
                        color: "#000000"
                       Text{
                            id:bubblenumber
                            anchors.centerIn: parent
                            text: "泡沫个数: "+imagevalue.BubbleNumber
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: tezheng1.height
                        color: "#000000"
                       Text{
                            id:graymean
                            anchors.centerIn: parent
                            text: "泡沫颜色: "+imagevalue.GrayMean
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: tezheng1.height
                        color: "#000000"
                       Text{
                            id:bubblefangcha
                            anchors.centerIn: parent
                            text: "泡沫方差"
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: tezheng1.height
                        color: "#000000"
                       Text{
                            id:chengzailv
                            anchors.centerIn: parent
                            text: "承载率"
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: tezheng1.height
                        color: "#000000"
                       Text{
                            id:bubblerate
                            anchors.centerIn: parent
                            text: "泡沫速度"
                            font.pixelSize:30
                            font.italic: true
                            color: "#00FF00"
                        }
                    }


                    }

}
                }

            }
        }
        MainWidget
        {
            id:widget4
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#990000FF"
                Text
                {
                    font.pointSize: 50
                    font.family: "微软雅黑"
                    color:"#FFFFFF"
                    anchors.centerIn: parent
                    text:"千里不留行"
                }
            }
        }
        MainWidget
        {
            id:widget5
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#FFFF9900"
                Text
                {
                    font.pointSize: 50
                    font.family: "微软雅黑"
                    color:"#FFFFFF"
                    anchors.centerIn: parent
                    text:"。"
                }
            }
        }
        MainWidget
        {
            id:widget6
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#FF00FFFF"
                Text
                {
                    font.pointSize: 50
                    font.family: "微软雅黑"
                    color:"#FFFFFF"
                    anchors.centerIn: parent
                    text:"事了拂衣去"
                }
            }
        }
        MainWidget
        {
            id:widget7
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#99FF00FF"
                Text
                {
                    font.pointSize: 50
                    font.family: "微软雅黑"
                    color:"#FFFFFF"
                    anchors.centerIn: parent
                    text:"，"
                }
            }
        }
        MainWidget
        {
            id:widget8
            visible: false
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: 10
                color:"#FFC0C0C0"
                Text
                {
                    font.pointSize: 50
                    font.family: "微软雅黑"
                    color:"#FFFFFF"
                    anchors.centerIn: parent
                    text:"深藏功与名。"
                }
            }
        }
    }
}
