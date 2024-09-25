const { app, BrowserWindow } = require('electron')

const createWindow = () => {
    const mainWindow = new BrowserWindow({
        width: 1000,
        height: 400,
        resizable: false
    })
    
    mainWindow.loadFile('index.html')
    mainWindow.setMenu(null)
}

app.whenReady().then(() => {
    createWindow()
})
