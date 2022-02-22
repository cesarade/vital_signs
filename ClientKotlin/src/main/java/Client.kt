import org.phoenixframework.Channel
import org.phoenixframework.Socket
import kotlin.random.Random

enum class TypeHeartRate {
    Normal,
    NormalTraining,
    ExcessiveTraining
}

class Client(
            val clientId: String,
            val url: String,
            val email: String,
            val specialistId: String,
            val typeHeartRate: TypeHeartRate) {

    lateinit var socket: Socket
    lateinit var channel: Channel

    private var fromHeartRate = 0
    private var toHeartRate = 0

    private var fromTemperature = 0.0
    private var toTemperature = 0.0

    private var steps = 0
    private var calories = 0


    init {
        initValue()
    }

    fun initValue(){
        when(typeHeartRate){
            TypeHeartRate.Normal -> {
                fromHeartRate = 60
                toHeartRate = 100

                fromTemperature = 36.1
                toTemperature = 37.2
            }
            TypeHeartRate.NormalTraining -> {
                fromHeartRate = 100
                toHeartRate = 160

                fromTemperature = 36.1
                toTemperature = 37.6
            }
            TypeHeartRate.ExcessiveTraining -> {
                fromHeartRate = 140
                toHeartRate = 200

                fromTemperature = 36.1
                toTemperature = 38.0
            }
        }
    }

    fun connectChannel(){

        val payload = HashMap<String, Any>();
        payload["specialist"] = specialistId

        // Join channels and listen to events
        channel = socket.channel("client:$clientId", payload)

        channel.join()
            .receive("ok") { /* Joined the chatroom */ }
            .receive("error") { /* failed to join the chatroom */ }
    }


    fun sendHeartRate(): Int{
        return Random.nextInt(fromHeartRate, toHeartRate)
    }

    fun sendTemperature(): Double{
        return Random.nextDouble(fromTemperature, toTemperature)
    }

    fun sendSteps(): Int {
        steps ++
        return steps
    }

    fun sendCalories(): Int {
        calories ++
        return calories
    }

    fun sendVitalSigns(){
        val send = HashMap<String, Any>();
        send["clientId"] = clientId
        send["client"] = email

        send["heartRateId"] = "899e6b2c-5fe7-4444-84ef-add3e28d7dc5"
        send["heartRate"] = sendHeartRate().toString()

        send["temperatureId"] = "8a1f0cd7-59d3-4dcd-9637-97344883c610"
        send["temperature"] = sendTemperature().toString()

        send["stepsId"] = "efc41bec-1ccf-4a3c-8d27-57076ff6174f"
        send["steps"] = sendSteps().toString()

        send["caloriesId"] = "83251a7c-4213-4227-9f9f-28eb6fab0ace"
        send["calories"] = sendCalories().toString()
        send["value_type"] = "integer"

        channel.push("vital_signs", send)
    }

//    Repo.insert!(%VitalSign{id: "899e6b2c-5fe7-4444-84ef-add3e28d7dc5",name: "heartRate", value_type: "double"})
//    Repo.insert!(%VitalSign{id: "8a1f0cd7-59d3-4dcd-9637-97344883c610",name: "temperature", value_type: "double"})
//    Repo.insert!(%VitalSign{id: "efc41bec-1ccf-4a3c-8d27-57076ff6174f",name: "steps", value_type: "integer"})
//    Repo.insert!(%VitalSign{id: "83251a7c-4213-4227-9f9f-28eb6fab0ace",name: "calories", value_type: "integer"})
//    Repo.insert!(%VitalSign{id: "0fbab19b-72e5-43c4-8c96-3989b15ff6f4",name: "blood pressure", value_type: "string"})




    fun connectSocket(){
        socket = Socket(url)

        socket.onOpen { println("TAG Socket Opened") }
        socket.onClose { println("TAG Socket Closed") }
        socket.onError {
                throwable, response -> println(throwable.toString() + " TAG Socket Error ${response?.code()}")
        }

        socket.connect()
    }


}