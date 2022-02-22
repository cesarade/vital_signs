import kotlin.random.Random

class VitalSigns {

    val clients = ArrayList<Client>()

    fun addClient(client: Client){
        clients.add(client)
    }

    fun connect(){
        for(client in clients){
            client.connectSocket()
            client.connectChannel()
        }
    }

    fun send(){
        while (true){
            Thread.sleep(1000)
            for (client in clients){
                client.sendVitalSigns()
            }
        }
    }

}