package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps

class PeakAndSoak extends Simulation {

  before {
        println("***** My simulation is about to begin! *****")
  }

  after {
        println("***** My simulation has ended! ******")
  }

  // LSD cluster node ips, currently hardcoded
  val ips: List[String] = List(
    "http://localhost:8080"
  )

  val httpConf = http
    .baseURLs(ips)
    .acceptHeader("application/json;q=0.9,*/*;q=0.8")
    .shareConnections
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0")
    .disableWarmUp

  val scn = scenario("PeakAndSoakScenario").exec( 
    http("login")
      .get("/login/wsmith")   
      .check(status.is(200))
  )

  setUp(

    scn.inject(
      constantUsersPerSec(10) during (10 seconds),
      constantUsersPerSec(5) during (10 seconds),
      constantUsersPerSec(15) during (10 seconds),
      constantUsersPerSec(5) during (10 seconds)
    )

  )
  .protocols(httpConf)
  .assertions(global.failedRequests.percent.lte(1)) 
  .assertions(global.responseTime.percentile4.lt(100)) 
}
