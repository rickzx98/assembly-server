import { ExpressApp, FluidInfo, FluidServer, path } from "./imports";

new FluidServer()
    .use(FluidInfo.CLUSTER_CONFIG)
    .use(FluidInfo.EXPRESS_SERVER_CONFIG, {
        express_static: path.join(__dirname, "..", "public")
    })
    .use(FluidInfo.EXPRESS_SERVER_SOCKET_IO_LISTENER, {
        express_host: "0.0.0.0",
        express_port: 80
    })
    .start()
    .then(()=>{
        ExpressApp.get("/product-info/:serialNo", (req,res)=>{
            res.sendFile(path.resolve(__dirname,"..","public","index.html"));   
        });
    })
    .catch(error => {
        console.error(error);
    }); 