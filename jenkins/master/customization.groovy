import jenkins.model.*
import hudson.model.Node.Mode
import hudson.slaves.*
import javaposse.jobdsl.plugin.GlobalJobDslSecurityConfiguration


Jenkins.instance.setNumExecutors(5)

def allStores = ["BBW6004", "BBW0025", "BBW0048", "VSS1521", "VSS2523", "VSS1607", "VSS0005", "VSS0023", "VSS0056", "VSS1748"]
String agentHome = "C:\\jenkins"
String agentExecutors = "2"


allStores.each {
    // There is a constructor that also takes a list of properties (env vars) at the end, but haven't needed that yet
  DumbSlave dumb = new DumbSlave(it,  // Agent name, usually matches the host computer's machine name
          it,           // Agent description
          agentHome,                  // Workspace on the agent's computer
          agentExecutors,             // Number of executors
          Mode.EXCLUSIVE,             // "Usage" field, EXCLUSIVE is "only tied to node", NORMAL is "any"
          it,                         // Labels
          new JNLPLauncher(true),         // Launch strategy, JNLP is the Java Web Start setting services use
          RetentionStrategy.INSTANCE) // Is the "Availability" field and INSTANCE means "Always"
  Jenkins.instance.addNode(dumb)
  println "Agent '$it' created with $agentExecutors executors and home '$agentHome'"
  println it+ " : "+jenkins.model.Jenkins.getInstance().getComputer(it).getJnlpMac()
}

// Disable Job DSL script approval

GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity=false
GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).save()