<template>
  <div>
    <div class="instructions">Choose your system</div>
    <div class="os-tabs">
      <div class="os-tab"
        v-for="system in systems"
        :class="{ 'selected': selectedSystem === system[0] }" @click="selectSystem(system[0])">
        <img :src="`/os/${system[0]}.svg`">
        <div class="os-label">{{system[1]}}</div>
      </div>
    </div>
    <div class="instructions" v-if="selectedSystem === 'tux'">Choose your package manager</div>
    <div class="distro-tabs" v-if="selectedSystem === 'tux'">
      <div class="distro-tab"
        :class="{ 'selected': selectedDistro === 'deb' }" @click="selectDistro('deb')">
        <div>
          <img src="/os/ubuntu.svg" title="Ubuntu" />
          <img src="/os/debian.svg" style="filter: grayscale(100%)" title="Debian" />
          <img src="/os/linuxmint.svg" title="Linux Mint" />
          <img src="/os/elementary.svg" style="margin-left: 2px" title="Elementary" />...
        </div>
        <div class="distro-label">APT (.deb packages)</div>
      </div>
      <div class="distro-tab"
        :class="{ 'selected': selectedDistro === 'rpm' }" @click="selectDistro('rpm')">
        <div>
          <img src="/os/redhat.svg" title="RedHat" />
          <img src="/os/opensuse.svg" style="margin-left: 2px; margin-bottom: 2px; filter: grayscale(100%) brightness(0)" title="openSUSE" />
          <img src="/os/mageia.svg" style="filter: grayscale(100%)" title="Mageia" />
          <img src="/os/fedora.svg" style="filter: grayscale(100%)" title="Fedora" />...
        </div>
        <div class="distro-label">RPM (.rpm packages)</div>
      </div>
    </div>
    <div class="instructions" v-if="selectedSystem">Choose your version</div>
    <div class="version-tabs" v-if="selectedSystem">
      <div class="version-tab"
        v-for="version in versions"
        :class="{ 'selected': selectedVersion === version[0] }" @click="selectVersion(version[0])">
        <strong>{{version[1]}}</strong><br />
        <small v-if="version[0] === 'stable'">{{$page.frontmatter.currentVersion}}</small>
        <small v-if="version[0] === 'testing'">{{$page.frontmatter.currentMilestoneVersion}}</small>
        <small v-if="version[0] === 'snapshot'">{{$page.frontmatter.currentSnapshotVersion}}</small>
      </div>
    </div>

    <div v-if="selectedVersion" class="version-explanation">
      <p v-if="selectedVersion === 'stable'"><strong>Stable</strong> versions are thoroughly tested semi-annual official releases of openHAB. Use the stable version for your production environment if you don't need the latest enhancements and prefer a robust system.</p>
      <p v-if="selectedVersion === 'testing'"><strong>Milestone</strong> versions are intermediary releases of the next openHAB version, released about once a month, and they include the new recently added features and bugfixes. They are a good compromise between the current stable version and the bleeding-edge and potentially unstable snapshot version.</p>
      <p v-if="selectedVersion === 'snapshot'"><strong>Snapshot</strong> versions are at most 1 or 2 days old and include the latest code. Use a snapshot for testing out very recent changes, but be aware some snapshots might be unstable. Use in production at your own risk!</p>
    </div>

    <!-- Raspberry Pi (openHABian with Raspberry Pi Imager) -->
    <div v-if="selectedSystem === 'raspberry-pi'">
      <hr>
      <h3>{{optionNumber('openhabian')}}Use Raspberry Pi Imager</h3>
      <ol>
        <div class="download-button-container">
          <a class="download-button big" target="_blank" href="https://www.raspberrypi.com/software/">Get Raspberry Pi Imager</a>
        </div>
        <li>Select your openHABian image under <code>Other specific-purpose OS - Home assistants and home automation</code>.</li>
        <li>Insert the SD card in your device, connect the Ethernet cable and turn it on.</li>
        <li>If you want to use Wi-Fi, openHABian will <router-link to="/docs/installation/openhabian.html#Wi-Fi-Hotspot">launch a hotspot</router-link>.</li>
        <li><router-link to="/docs/installation/openhabian.html">Please read the docs</router-link> while your box is installing openHABian.</li>
        <li>Navigate with a web browser to <code>http://openhabian:8080</code></li>
        <li v-if="selectedVersion !== 'stable'">Use the <code>openhabian-config</code> tool (<router-link to="/docs/installation/openhabian.html#openhabian-configuration-tool">documentation</router-link>) to switch from the stable version to the {{selectedVersion}} version</li>
        <li>Continue by following the <router-link to="/docs/tutorial/">tutorial</router-link> to get started</li>
      </ol>
    </div>

    <!-- Linux Deb & Raspberry Pi -->
    <div v-if="(selectedSystem === 'tux' && selectedDistro === 'deb') || selectedSystem === 'raspberry-pi'">
      <hr>
      <h3>{{optionNumber('package')}}Install the APT Packages <span v-if="selectedSystem === 'tux'">(Recommended)</span></h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <div class="tip custom-block">
        <p class="custom-block-title">TIP</p>
        <p>On Debian systems you can also opt to add our openHABian turn-key solution on top of your existing operating system, follow <router-link to="/docs/installation/openhabian.html#other-linux-systems-add-openhabian-just-like-any-other-software">these instructions instead</router-link> to check whether your system is eligible and install it.</p>
        <p v-if="selectedSystem === 'raspberry-pi'">For Raspberry Pi, however, we strongly recommend flashing the complete OS image, see above.</p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction" />
        <li>Add the repository key</li>
          <div class="language-shell"><pre class="language-shell"><code>curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor > openhab.gpg
sudo mkdir /usr/share/keyrings
sudo mv openhab.gpg /usr/share/keyrings
sudo chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg</code></pre></div>
        <li>Add the HTTPS transport for APT</li>
          <div class="language-shell"><pre class="language-shell"><code>sudo apt-get install apt-transport-https</code></pre></div>
        <li>Add the repository</li>
          <div class="language-shell"><pre class="language-shell"><code v-if="selectedVersion === 'stable'">echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main' | sudo tee /etc/apt/sources.list.d/openhab.list</code><code v-else-if="selectedVersion === 'testing'">echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg testing main' | sudo tee /etc/apt/sources.list.d/openhab.list</code><code v-else="selectedVersion === 'snapshot'">echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg unstable main' | sudo tee /etc/apt/sources.list.d/openhab.list</code></pre></div>
        <li>Update the package lists and install the openHAB distribution package</li>
          <div class="language-shell"><pre class="language-shell"><code>sudo apt-get update && sudo apt-get install openhab</code></pre></div>
        <li><strong>(Optional)</strong> Install the add-ons for offline use</li>
        &#128712; <small>	You don't need the add-ons package if your machine has Internet access, openHAB will download add-ons online as necessary.</small>
          <div class="language-shell"><pre class="language-shell"><code>sudo apt-get install openhab-addons</code></pre></div>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>Continue by following the <router-link to="/docs/tutorial/">tutorial</router-link> to get started</li>
      </ol>
    </div>
    <!-- Linux RPM -->
    <div v-if="selectedSystem === 'tux' && selectedDistro === 'rpm'">
      <hr>
      <h3>{{optionNumber('package')}}Install the RPM Packages (Recommended)</h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction" />
        <li>Create a new <code>/etc/yum.repos.d/openhab.repo</code> file with the following content:</li>
        <div class="language-ini">
<pre class="language-ini"><code>[openHAB-{{selectedVersion === 'stable' ? 'Stable' : selectedVersion === 'testing' ? 'Testing' : 'Snapshots'}}]
name=openHAB {{selectedVersion === 'stable' ? 'Stable' : selectedVersion === 'testing' ? 'Testing' : 'Snapshots'}}
baseurl={{selectedVersion === 'stable' ? 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/stable' : selectedVersion === 'testing' ? 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/testing' : 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/unstable'}}
gpgcheck=1
gpgkey=https://openhab.jfrog.io/artifactory/api/gpg/key/public
enabled=1
</code></pre>
        </div>
        <li>Install the openHAB distribution package</li>
          <div class="language-shell"><pre class="language-shell"><code>sudo yum install openhab</code></pre></div>
        <li><strong>(Optional)</strong> Install the add-ons for offline use</li>
        &#128712; <small>	You don't need the add-ons package if your machine has Internet access, openHAB will download add-ons online as necessary.</small>
          <div class="language-shell"><pre class="language-shell"><code>sudo yum install openhab-addons</code></pre></div>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>Continue by following the <router-link to="/docs/tutorial/">tutorial</router-link> to get started</li>
      </ol>
    </div>

    <!-- Docker -->
    <div v-if="selectedSystem === 'docker'">
      <hr>
      <h3>Docker Container Quick Installation</h3>
      <p>These are very simplified instructions, check the <router-link to="/docs/installation/docker.html">documentation article</router-link> or <a target="_blank" href="https://hub.docker.com/r/openhab/openhab/">https://hub.docker.com/r/openhab/openhab/</a> for more information.</p>
      <ol>
        <li>Create the <code>openhab</code> user:</li>
        <div class="language-shell">
<pre class="language-shell"><code>groupadd -g 9001 openhab
useradd -g 9001 openhab
usermod -a -G openhab myownuser
</code></pre>
        </div>
        <li>Pull and run the container (command line version):</li>
        <div class="language-shell">
<pre class="language-shell"><code>docker run \
        --name openhab \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/timezone:/etc/timezone:ro \
        -v openhab_addons:/openhab/addons \
        -v openhab_conf:/openhab/conf \
        -v openhab_userdata:/openhab/userdata \
        -d \
        --restart=always \
        openhab/openhab:{{selectedVersion === 'stable' ? $page.frontmatter.currentVersion : selectedVersion === 'testing' ? $page.frontmatter.currentMilestoneVersion : $page.frontmatter.currentSnapshotVersion.toLowerCase()}}
</code></pre>
        </div>
        <li><strong>(Optional)</strong> Download the add-on archives for offline use and put them in the volume mapped to <code>/openhab/addons</code>:</li>
        &#128712; <small>	You don't need the add-ons archives if your machine has Internet access, openHAB will download add-ons you need online as necessary.</small>
        <div v-if="(selectedVersion === 'stable' || selectedVersion === 'testing')">
            <div class="download-button-container">
              <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>Download openHAB {{currentDownloadVersion}} {{currentVersionLabel}} Add-ons</a>
            </div>
        </div>
        <div v-if="selectedVersion === 'snapshot'">
            <div class="download-button-container">
              <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>Download openHAB {{$page.frontmatter.currentSnapshotVersion}} Add-ons</a>
            </div>
        </div>
      </ol>
    </div>

    <!-- MacOS Homebrew -->
    <div v-if="selectedSystem === 'apple' && selectedVersion !== 'snapshot'">
      <hr>
      <h3>{{optionNumber('package')}}Install the Homebrew Package (Recommended)</h3>
      <ol>
        <li>Install the <a target="_blank" href="https://brew.sh">Homebrew</a> package manager</li>
        <li>Add the <a target="_blank" href="https://github.com/openhab/homebrew-openhab">openHAB Homebrew tap</a> (taps are third-party repositories in Homebrew)</li>
        <div class="language-shell"><pre class="language-shell"><code>brew tap openhab/openhab</code></pre></div>
        <li>Install the openHAB package</li>
        &#128712; <small> This will automatically install the <code>openjdk@21</code> package.</small>
        <div class="language-shell"><pre class="language-shell"><code>brew install {{ homebrewPackageName }}</code></pre></div>
        <li>Pin both the openHAB & Java package versions</li>
        &#128712; <small> This prevents Homebrew from upgrading those packages when running </small>
        <div class="language-shell"><pre class="language-shell"><code>brew pin openjdk@21 {{ homebrewPackageName }}</code></pre></div>
        <li><strong>(Optional)</strong> Install the add-ons for offline use</li>
        &#128712; <small>	You don't need the add-ons package if your machine has Internet access, openHAB will download add-ons online as necessary.</small>
        <div>The openHAB homebrew package will provide you with the necessary instructions to install add-ons for offline use, simply type <code>brew info {{ homebrewPackageName }}</code>.</div>
        <li>Start openHAB as a service, then wait wait for openHAB to perform its initial startup (this can take a few minutes depending on your machine)</li>
        <div class="language-shell"><pre class="language-shell"><code>brew services start {{ homebrewPackageName }}</code></pre></div>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>Continue by following the <router-link to="/docs/tutorial/">tutorial</router-link> to get started</li>
      </ol>
      <p>More detailed installation instructions can be found in the <a target="_blank" href="/docs/installation/macos.html">macOS Installation Docs</a>.</p>
    </div>

    <!-- Manual installation -->
    <div v-if="selectedSystem !== 'docker'">
      <hr>
      <h3>{{optionNumber('manual')}}Manual Installation</h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction" />
        <li>Download and extract the openHAB runtime distribution:</li>
        <div class="download-button-container">
          <a class="download-button big" :href="runtimeDownloadLink" download>Download openHAB {{currentDownloadVersion}} {{currentVersionLabel}} Runtime</a>
        </div>
        <li><strong>(Optional)</strong> Download the add-on archives for offline use and put them in the <code>addons</code> folder of the extracted distribution:</li>
        &#128712; <small>	You don't need the add-ons archives if your machine has Internet access, openHAB will download add-ons you need online as necessary.</small>
        <div class="download-button-container">
          <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>Download openHAB {{currentDownloadVersion}} {{currentVersionLabel}} Add-ons</a>
        </div>
        <li v-if="selectedSystem === 'apple'">
          Open <em>System Preferences &gt; Keyboard &gt; Shortcuts</em> and check the <em>New Terminal at Folder</em> option under <em>Services</em>:<br />
          <img class="img-center" src="./images/macos-settings.png" />
        </li>
        <li v-if="selectedSystem === 'apple'">
          Using the Finder, find the folder with the extracted runtime (look into the Downloads folder), then open its context menu and select <em>New Terminal at Folder</em>:<br /><br />
          <img class="img-center" src="./images/macos-contextmenu.png" /><br />
        </li>
        <li>
          <span v-if="selectedSystem !== 'windows'">Run <code>{{ selectedSystem === 'win10' ? 'start.bat' : './start.sh'}}</code></span>
          <span v-if="selectedSystem === 'apple'"> in the Terminal</span>
          and wait for openHAB to perform its initial startup (this can take a few minutes depending on your machine)</li>
        <li>Navigate with a web browser to <code>http://{{selectedSystem === 'apple' || selectedSystem === 'win10' ? 'localhost' : '&lt;ip-address&gt;'}}:8080</code></li>
        <li>Continue by following the <router-link to="/docs/tutorial/">tutorial</router-link> to get started</li>
      </ol>
    </div>

    <!-- <div v-if="selectedSystem === 'win10' && selectedVersion === 'stable'">
      <hr>
      <h3>Install with Chocolatey</h3>
      <div class="danger custom-block">
        <p class="custom-block-title">Unofficial installation method</p>
        <p>Please note, the Chocolatey package is a community-provided installation option presented here as a convenience, and is not officially supported by the openHAB project.</p>
      </div>
      <ol>
        <li>Right-click on the Start menu and select <em>Command Prompt (admin)</em> or <em>Windows PowerShell (admin)</em></li>
        <li>Install the <a target="_blank" href="https://chocolatey.org/install">Chocolatey</a> package manager by running one of these commands:
          <ul>
            <li>If you opened a command prompt (cmd.exe)
            <div class="language-shell"><pre class="language-shell"><code>@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"</code></pre></div></li>
            <li>If you opened PowerShell
            <div class="language-shell"><pre class="language-shell"><code>Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))</code></pre></div></li>
          </ul>
        </li>
        <li>Install the <a target="_blank" href="https://chocolatey.org/packages/openhab">openHAB Chocolatey package</a>:</li>
        <div class="language-shell"><pre class="language-shell"><code>choco install openhab</code></pre></div>
      </ol>
    </div> -->

  </div>

</template>

<style lang="stylus">
.instructions
  margin-top 1rem
  margin-bottom .3rem
  font-size 1.5rem
  font-weight bold
  text-align center
  font-family 'Open Sans', sans-serif
  font-weight 400
.os-tabs
  display flex
  flex-direction row
  align-items justify
  align-content center
  justify-content center
  .os-tab
    margin auto
    width 17%
    padding 3px
    text-align center
    position relative
    border 2px solid transparent
    cursor pointer
    &:hover
      background #f0f0f0
    &.selected
      border 2px solid #ff6600
    img
      height 48px
      display block
      position absolute
      left 50%
      transform translateX(-50%)
      object-fit contain
    .os-label
      margin-top 48px
      font-size 12px

.distro-tabs
  display flex
  flex-direction row
  align-items center
  align-content center
  justify-content center
  .distro-tab
    width 30%
    padding 3px
    text-align center
    position relative
    border 2px solid transparent
    cursor pointer
    font-size 15px
    img
      height 24px
    &:hover
      background #f0f0f0
    &.selected
      border 2px solid #ff6600

.version-tabs
  display flex
  flex-direction row
  align-items center
  align-content center
  justify-content center
  .version-tab
    width 20%
    padding 3px
    text-align center
    position relative
    border 2px solid transparent
    cursor pointer
    font-size 15px
    &:hover
      background #f0f0f0
    &.selected
      border 2px solid #ff6600

.version-explanation
  padding 3px
  margin-top 1rem
  margin-bottom 1rem
  text-align center
  font-size 14px

.download-button-container
  display flex
  flex-direction row
  align-items center
  align-content center
  justify-content center
.download-button
  margin 2rem
  display inline-block
  font-family 'Open Sans', sans-serif
  font-size 0.9rem
  color #ff6600
  padding 0.8rem 1.6rem
  border-radius 4px
  font-weight bold
  transition background-color .1s ease
  box-sizing border-box
  border 2px solid #ff6600
  &.big
    font-size 1.2rem
  &:hover
    background-color #ff6600
    color white
    text-decoration none !important

.img-center
  display block
  margin-left auto
  margin-right auto
  max-width 75%

@media (max-width: 480px)
  .os-tabs
    flex-flow wrap
    column-count 3
    .os-tab
      width 33%
  .distro-tabs
    .distro-tab
      width 50%
  .version-tabs
    .version-tab
      width 40%

</style>

<script>
export default {
  data () {
    return {
      systems: [
        ['raspberry-pi', 'Raspberry Pi'],
        ['tux', 'Linux'],
        ['win10', 'Windows'],
        ['apple', 'macOS'],
        ['docker', 'Docker'],
      ],
      selectedSystem: 'raspberry-pi',
      selectedDistro: 'deb',
      selectedVersion: 'stable',
      optionsCounter: 1
    }
  },
  methods: {
    selectSystem (system) {
      this.selectedSystem = system
    },
    selectVersion (version) {
      this.selectedVersion = version
    },
    selectDistro (distro) {
      this.selectedDistro = distro
    },
    optionNumber (type) {
      if (type === 'openhabian') return 'Option 1: '
      if (type === 'package' && this.selectedSystem === 'tux') return 'Option 1: '
      if (type === 'package' && this.selectedSystem === 'raspberry-pi') return 'Option 2: '
      if (type === 'package' && this.selectedSystem === 'apple') return 'Option 1: '
      if (type === 'manual' && this.selectedSystem === 'tux') return 'Option 2: '
      if (type === 'manual' && this.selectedSystem === 'raspberry-pi') return 'Option 3: '
      if (type === 'manual' && this.selectedSystem === 'apple') return this.selectedVersion === 'snapshot' ? '' : 'Option 2: '
      return ''
    }
  },
  computed: {
    versions () {
      let ret = []
      ret.push(['stable', 'Stable'])
      if (this.$page.frontmatter.currentMilestoneVersion) ret.push(['testing', 'Milestone'])
      ret.push(['snapshot', 'Snapshot'])
      return ret
    },
    runtimeDownloadLink () {
      if (this.selectedVersion === 'stable') {
        return `https://github.com/openhab/openhab-distro/releases/download/${this.$page.frontmatter.currentVersion}/openhab-${this.$page.frontmatter.currentVersion}.zip`
      } else if (this.selectedVersion === 'testing') {
        return `https://github.com/openhab/openhab-distro/releases/download/${this.$page.frontmatter.currentMilestoneVersion}/openhab-${this.$page.frontmatter.currentMilestoneVersion}.zip`
      } else {
        return `https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab/target/openhab-${this.$page.frontmatter.currentSnapshotVersion}.zip`
      }
    },
    addonsDownloadLink () {
      if (this.selectedVersion === 'stable') {
        return `https://github.com/openhab/openhab-distro/releases/download/${this.$page.frontmatter.currentVersion}/openhab-addons-${this.$page.frontmatter.currentVersion}.kar`        
      } else if (this.selectedVersion === 'testing') {
        return `https://github.com/openhab/openhab-distro/releases/download/${this.$page.frontmatter.currentMilestoneVersion}/openhab-addons-${this.$page.frontmatter.currentMilestoneVersion}.kar`
      } else {
        return `https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons/target/openhab-addons-${this.$page.frontmatter.currentSnapshotVersion}.kar`
      }
    },
    currentDownloadVersion () {
      if (this.selectedVersion === 'stable') {
        return this.$page.frontmatter.currentVersion
      } else if (this.selectedVersion === 'testing') {
        return this.$page.frontmatter.currentMilestoneVersion
      } else {
        return this.$page.frontmatter.currentSnapshotVersion
      }
    },
    currentVersionLabel () {
      if (this.selectedVersion) {
        return this.versions.find(v => v[0] === this.selectedVersion)[1]
      }
    },
    javaDownloadInstruction () {
      return `Install a recent Java 21 platform (we recommend your OS package repository provided OpenJDK build, or the <a target="_blank" href="https://adoptium.net/de/temurin/releases/?version=21&package=jre">Eclipse Adoptium Temurin</a> builds of OpenJDK)`
    },
    homebrewPackageName () {
      if (this.selectedVersion === 'stable') return 'openhab'
      return 'openhab-milestone'
    }
  }
}
</script>
