import SwiftUI

#Preview("ParentFrame has less tall size, with ScrollView") {
    VStack(spacing: 150) {
        ScrollView {
            HStack(spacing: 10) {
                Text("aa")
                Rectangle().fill(.red)
                    .frame(width: 50, height: 200)
            }
            ScrollView {
                MyHStack(spacing: 10) {
                    Text("aa")
                    Rectangle().fill(.yellow)
                        .frame(width: 50, height: 200)
                }
            }
        }
    }
}

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

#Preview("Text and Rectagnle in ScrollView") {
    VStack(spacing: 10) {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.red)
                Text("a")
                Rectangle().fill(.red)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.green)
                Text("a")
                Rectangle().fill(.green)
            }
        }
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

#Preview("Hstack with ScrollView") {
    VStack {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
            }
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
    VStack {
        VStack {
            HStack {
                Text("Text")
            }
            HStack {
                Color.yellow
            }
            HStack {
                Color.yellow
                Text("Text")
            }
            HStack {
                Text("Text")
                Text("Text")
            }
            HStack {
                Color.yellow
                Color.green
            }
            HStack {
                Color.yellow
                HStack {
                    Color.gray
                    Color.green
                }
            }
        }
    }
    
    VStack {
        VStack {
            MyHStack {
                Text("Text")
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
                    Color.gray
                    Color.green
                }
            }
        }
    }
}

