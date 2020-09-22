import zio.ZIO
import zio.console.{Console, putStrLn}
import zio._

import scala.concurrent.Future

object Application extends zio.App {

  def okFuture: Future[String] = Future.successful("ok")

  val program: ZIO[Console, Throwable, Unit] = for {
    _ <- putStrLn("this program run on: " + Thread.currentThread().getName)
    f <- ZIO.fromFuture { ec => okFuture }
    _ <- putStrLn(s"program1, got result from Future $f")
  } yield ()

  override def run(args: List[String]): zio.URIO[zio.ZEnv,zio.ExitCode] = program.exitCode
}