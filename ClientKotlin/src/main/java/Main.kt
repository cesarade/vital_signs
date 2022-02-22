import org.phoenixframework.Socket
import kotlin.random.Random



fun main(args: Array<String>) {
    //    connectoToChannel()

    val client1 = Client(
        "cfe8c81b-9c39-4ee1-96d7-f6ad28ff731b",
        "http://localhost:4000/socket/websocket",
        "miguel@email.com",
    "8ba687d3-5990-40bd-89c1-cc19f7630f13",
    TypeHeartRate.Normal)

    val client2 = Client(
        "df206c29-bfd0-448d-940b-c7ca37617f20",
        "http://localhost:4000/socket/websocket",
        "leslie@email.com",
        "8ba687d3-5990-40bd-89c1-cc19f7630f13",
        TypeHeartRate.NormalTraining)

    val vitalSigns = VitalSigns()
    vitalSigns.addClient(client1)
    vitalSigns.addClient(client2)

    vitalSigns.connect()
    vitalSigns.send()
}