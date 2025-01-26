import SwiftUI

#Preview("ParentFrame has less tall size") {
    VStack(spacing: 150) {
        HStack(spacing: 10) {
            Text("aa")
            Rectangle().fill(.red)
                .frame(width: 50, height: 200)
        }.frame(width: 100, height: 100)
        MyHStack(spacing: 10) {
            Text("aa")
            Rectangle().fill(.yellow)
                .frame(width: 50, height: 200)
        }.frame(height: 100)
    }
}

#Preview("ParentFrame not enough width") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("aaaaaa")
            Text("bbbbbbbbbbbbb")
        }.frame(width: 20)
            .foregroundColor(.red)
        MyHStack(spacing: 10) {
            Text("aaaaaa")
            Text("bbbbbbbbbbbbb")
        }.frame(width: 20)
            .foregroundColor(.yellow)
    }
}

#Preview("Text and Rectangle") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.red)
            Text("a")
            Rectangle().fill(.red)
        }
        MyHStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.green)
            Text("a")
            Rectangle().fill(.green)
        }
    }
}

#Preview("HStack with padding") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Rectangle().fill(.blue)
            Rectangle().fill(.red)
        }.padding(.horizontal, 100)
        
        MyHStack(spacing: 10) {
            Rectangle().fill(.yellow)
            Rectangle().fill(.green)
        }.padding(.horizontal, 100)
    }
}

#Preview("Hstack with spacing") {
    VStack(spacing: 10) {
        Text("Spacing: 0")
        HStack(spacing: 0) {
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
            Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(spacing: 0) {
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Spacing: 20")
        HStack(spacing: 20) {
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
            Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(spacing: 20) {
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
        }
    }
}

#Preview("Hstack with alignment") {
    VStack {
        Text("Top")
        HStack(alignment: .top, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .top, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Center")
        HStack(alignment: .center, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .center, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Bottom")
        HStack(alignment: .bottom, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .bottom, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
    }
}

#Preview("with MaxWidth") {
    VStack {
        HStack {
            Text("titleTitleTitleTitleTitle")
                .frame(maxWidth: .infinity)
                .background(Color.red)
            Text("Subtitle")
                .frame(maxWidth: 100, alignment: .trailing)
                .background(Color.blue)
        }
        MyHStack {
            Text("titleTitleTitleTitleTitle")
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
            Text("Subtitle")
                .frame(maxWidth: 100, alignment: .trailing)
                .background(Color.green)
        }
    }
}

#Preview("Image") {
    VStack {
        HStack {
            Image(systemName: "moon")
                .border(.red)
                .frame(width: 100, height: 100)
            Image(systemName: "moon")
                .resizable()
                .border(.red)
                .frame(width: 100, height: 100)
        }
        MyHStack {
            Image(systemName: "moon")
                .border(.red)
                .frame(width: 100, height: 100)
            Image(systemName: "moon")
                .resizable()
                .border(.red)
                .frame(width: 100, height: 100)
        }
    }
}

#Preview("Many view") {
    VStack(spacing: 30) {
        VStack {
            VStack {
                HStack {
                    Text("Original HStack")
                        .font(.title)
                }
                HStack {
                    Color.red
                }
                HStack {
                    Color.red
                    Text("Text")
                }
                HStack {
                    Text("Text")
                    Text("Text")
                }
                HStack {
                    Color.red
                    Color.blue
                }
                HStack {
                    Color.red
                    HStack {
                        Color.red
                        Color.blue
                    }
                }
            }
        }
        
        VStack {
            VStack {
                MyHStack {
                    Text("MyHSack")
                        .font(.title)
                }
                MyHStack {
                    Color.yellow
                }
                MyHStack {
                    Color.yellow
                    Text("Text")
                }
                MyHStack {
                    Text("Text")
                    Text("Text")
                }
                MyHStack {
                    Color.yellow
                    Color.green
                }
                MyHStack {
                    Color.yellow
                    MyHStack {
                        Color.yellow
                        Color.green
                    }
                }
            }
        }
    }
}

#Preview("Highest Priority view has fixed width") {
    VStack(spacing: 100) {
        HStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(width: 50)
                .layoutPriority(100)
            //H 100
            Rectangle()
        }.frame(width: 200)
        
        MyHStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(width: 50)
                .layoutPriority(100)
            //H 100
            Rectangle()
        }.frame(width: 200)
    }
}

#Preview("H of Parent is smaller than ideal, W is in screen") {
    VStack(spacing: 100) {
        HStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(idealWidth: 50, idealHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 50, minHeight: 10)
            //H 50
            Rectangle()
                .frame(idealWidth: 50, maxHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 50, maxHeight: 150)
            //H 150
            Rectangle()
                .frame(idealWidth: 50, minHeight: 150)
        }
        .frame(maxHeight: 100)
        MyHStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(idealWidth: 50, idealHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 50, minHeight: 10)
            //H 50
            Rectangle()
                .frame(idealWidth: 50, maxHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 50, maxHeight: 150)
            //H 150
            Rectangle()
                .frame(idealWidth: 50, minHeight: 150)
        }
        .frame(maxHeight: 100)
    }
}

#Preview("Spacer") {
    VStack(spacing: 100) {
        HStack(spacing: 10) {
            Rectangle().fill(.red)
            Spacer()
            Rectangle().fill(.yellow)
        }
        MyHStack(spacing: 10) {
            Rectangle().fill(.red)
            Spacer()
            Rectangle().fill(.yellow)
        }
    }
    
}

#Preview("Spacer") {
    VStack(spacing: 100) {
        HStack(spacing: 40) {
            Text("a")
            Rectangle().fill(.red)
                .layoutPriority(99)
            Spacer()
            Rectangle().fill(.yellow)
                .layoutPriority(100)
        }
        MyHStack(spacing: 40) {
            Text("a")
            Rectangle().fill(.red)
                .layoutPriority(99)
            Spacer()
            Rectangle().fill(.yellow)
                .layoutPriority(100)
        }
    }
}

#Preview("Text and Rectangle") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.red)
                .frame(minHeight: 100)
            Text("a")
            Rectangle().fill(.red)
        }
        MyHStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.green)
                .frame(minHeight: 100)
            Text("a")
            Rectangle().fill(.green)
        }
    }
}

#Preview("with min width") {
    VStack {
        HStack {
            Rectangle()
                .fill(.red)
                .frame(minWidth: 100)
            Rectangle()
                .fill(.blue)
                .frame(minWidth: 100, maxWidth: 250)
        }.frame(width: 400)
        MyHStack {
            Rectangle()
                .fill(.green)
                .frame(minWidth: 100)
            Rectangle()
                .fill(.yellow)
                .frame(minWidth: 100, maxWidth: 250)
        }.frame(width: 400)
    }
}

#Preview("Rectangle, but parent view has not enough width") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Rectangle().fill(.red)
                .frame(width: 80)
            Rectangle().fill(.blue)
                .frame(width: 50)
        }.frame(width: 100)
        
        MyHStack(spacing: 10) {
            MyHStack(spacing: 10) {
                Rectangle().fill(.red)
                    .frame(width: 80)
                Rectangle().fill(.blue)
                    .frame(width: 50)
            }.frame(width: 100)
        }
    }
}

#Preview("0Width") {
    VStack {
        HStack(spacing: 10) {
            Rectangle()
            Rectangle()
                .frame(width: 0)
            Rectangle()
        }
        
        MyHStack(spacing: 10) {
            Rectangle()
            Rectangle()
                .frame(width: 0)
            Rectangle()
        }
    }
}

#Preview("H of Parent is smaller than ideal, w is out of screen.") {
    VStack(spacing: 100) {
        HStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(idealWidth: 100, idealHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 100, minHeight: 10)
            //H 50
            Rectangle()
                .frame(idealWidth: 100, maxHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 100, maxHeight: 150)
            //H 150
            Rectangle()
                .frame(idealWidth: 100, minHeight: 150)
        }
        .frame(maxHeight: 100)
        MyHStack(spacing: 10) {
            //H 100
            Rectangle()
                .frame(idealWidth: 100, idealHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 100, minHeight: 10)
            //H 50
            Rectangle()
                .frame(idealWidth: 100, maxHeight: 50)
            //H 100
            Rectangle()
                .frame(idealWidth: 100, maxHeight: 150)
            //H 150
            Rectangle()
                .frame(idealWidth: 100, minHeight: 150)
        }
        .frame(maxHeight: 100)
    }
}
