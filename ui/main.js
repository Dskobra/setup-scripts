const { app, BrowserWindow } = require('electron/main')
const path = require('node:path')

const createWindow = () => {
    const mainWindow = new BrowserWindow({
        width: 900,
        height: 400,
        resizable: false
    })
    
    mainWindow.loadFile('index.html')
    //mainWindow.setMenu(null)          // menu enabled for debugging. Might create a custom toolbar later
}

app.whenReady().then(() => {
    createWindow()
})
