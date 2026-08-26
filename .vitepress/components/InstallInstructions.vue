<template>
  <div>
    <div class="instructions">Choose your system</div>
    <div class="os-tabs">
      <div
        v-for="system in systems"
        :key="system[0]"
        class="os-tab"
        :class="{ selected: selectedSystem === system[0] }"
        @click="selectSystem(system[0])"
      >
        <img :src="withBase(`/os/${system[0]}.svg`)" :alt="system[1]" />
        <div class="os-label">{{ system[1] }}</div>
      </div>
    </div>

    <div class="instructions" v-if="selectedSystem === 'tux'">Choose your package manager</div>
    <div class="distro-tabs" v-if="selectedSystem === 'tux'">
      <div class="distro-tab" :class="{ selected: selectedDistro === 'deb' }" @click="selectDistro('deb')">
        <div>
          <img :src="withBase('/os/ubuntu.svg')" title="Ubuntu" alt="Ubuntu" />
          <img :src="withBase('/os/debian.svg')" style="filter: grayscale(100%)" title="Debian" alt="Debian" />
          <img :src="withBase('/os/linuxmint.svg')" title="Linux Mint" alt="Linux Mint" />
          <img :src="withBase('/os/elementary.svg')" style="margin-left: 2px" title="Elementary" alt="Elementary" />...
        </div>
        <div class="distro-label">APT (.deb packages)</div>
      </div>
      <div class="distro-tab" :class="{ selected: selectedDistro === 'rpm' }" @click="selectDistro('rpm')">
        <div>
          <img :src="withBase('/os/redhat.svg')" title="RedHat" alt="RedHat" />
          <img
            :src="withBase('/os/opensuse.svg')"
            style="margin-left: 2px; margin-bottom: 2px; filter: grayscale(100%) brightness(0)"
            title="openSUSE"
            alt="openSUSE"
          />
          <img :src="withBase('/os/mageia.svg')" style="filter: grayscale(100%)" title="Mageia" alt="Mageia" />
          <img :src="withBase('/os/fedora.svg')" style="filter: grayscale(100%)" title="Fedora" alt="Fedora" />...
        </div>
        <div class="distro-label">RPM (.rpm packages)</div>
      </div>
    </div>

    <div class="instructions" v-if="selectedSystem">Choose your version</div>
    <div class="version-tabs" v-if="selectedSystem">
      <div
        v-for="version in versions"
        :key="version[0]"
        class="version-tab"
        :class="{ selected: selectedVersion === version[0] }"
        @click="selectVersion(version[0])"
      >
        <strong>{{ version[1] }}</strong>
        <small v-if="version[0] === 'stable'">{{ frontmatter.currentVersion }}</small>
        <small v-if="version[0] === 'testing'">{{ frontmatter.currentMilestoneVersion }}</small>
        <small v-if="version[0] === 'snapshot'">{{ frontmatter.currentSnapshotVersion }}</small>
      </div>
    </div>

    <div v-if="selectedVersion" class="version-explanation">
      <p v-if="selectedVersion === 'stable'">
        <strong>Stable</strong> versions are thoroughly tested semi-annual official releases of openHAB. Use the stable version for your production environment if you don't need the latest enhancements and prefer a robust system.
      </p>
      <p v-if="selectedVersion === 'testing'">
        <strong>Milestone</strong> versions are intermediary releases of the next openHAB version, released about once a month, and they include the new recently added features and bugfixes. They are a good compromise between the current stable version and the bleeding-edge and potentially unstable snapshot version.
      </p>
      <p v-if="selectedVersion === 'snapshot'">
        <strong>Snapshot</strong> versions are at most 1 or 2 days old and include the latest code. Use a snapshot for testing out very recent changes, but be aware some snapshots might be unstable. Use in production at your own risk!
      </p>
    </div>

    <!-- Raspberry Pi (openHABian with Raspberry Pi Imager) -->
    <div v-if="selectedSystem === 'raspberry-pi'">
      <hr />
      <h3>{{ optionNumber('openhabian') }}Use Raspberry Pi Imager</h3>
      <div class="download-button-container">
        <a class="download-button big" target="_blank" href="https://www.raspberrypi.com/software/" rel="noopener noreferrer">
          Get Raspberry Pi Imager
        </a>
      </div>
      <ol>
        <li>Select your openHABian image under <code>Other specific-purpose OS - Home assistants and home automation</code>.</li>
        <li>Insert the SD card in your device, connect the Ethernet cable and turn it on.</li>
        <li>
          If you want to use Wi-Fi, openHABian will
          <a :href="withBase('/docs/installation/openhabian.html#Wi-Fi-Hotspot')">launch a hotspot</a>.
        </li>
        <li>
          <a :href="withBase('/docs/installation/openhabian.html')">Please read the docs</a> while your box is installing openHABian.
        </li>
        <li>Navigate with a web browser to <code>http://openhabian:8080</code></li>
        <li v-if="selectedVersion !== 'stable'">
          Use the <code>openhabian-config</code> tool (
          <a :href="withBase('/docs/installation/openhabian.html#openhabian-configuration-tool')">documentation</a>
          ) to switch from the stable version to the {{ selectedVersion }} version
        </li>
        <li>
          Continue by following the <a :href="withBase('/docs/tutorial/')">tutorial</a> to get started
        </li>
      </ol>
    </div>

    <!-- Linux Deb & Raspberry Pi -->
    <div v-if="(selectedSystem === 'tux' && selectedDistro === 'deb') || selectedSystem === 'raspberry-pi'">
      <hr />
      <h3>
        {{ optionNumber('package') }}Install the APT Packages <span v-if="selectedSystem === 'tux'">(Recommended)</span>
      </h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <div class="tip custom-block">
        <p class="custom-block-title">TIP</p>
        <p>
          On Debian systems you can also opt to add our openHABian turn-key solution on top of your existing operating system, follow
          <a :href="withBase('/docs/installation/openhabian.html#other-linux-systems-add-openhabian-just-like-any-other-software')">
            these instructions instead
          </a>
          to check whether your system is eligible and install it.
        </p>
        <p v-if="selectedSystem === 'raspberry-pi'">
          For Raspberry Pi, however, we strongly recommend flashing the complete OS image, see above.
        </p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction"></li>
        <li>
          Add the repository key
          <div class="language-shell">
            <pre class="language-shell"><code>curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor &gt; openhab.gpg
sudo mkdir /usr/share/keyrings
sudo mv openhab.gpg /usr/share/keyrings
sudo chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg</code></pre>
          </div>
        </li>
        <li>
          Add the HTTPS transport for APT
          <div class="language-shell">
            <pre class="language-shell"><code>sudo apt-get install apt-transport-https</code></pre>
          </div>
        </li>
        <li>
          Add the repository
          <div class="language-shell">
            <pre class="language-shell"><code v-if="selectedVersion === 'stable'">echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main' | sudo tee /etc/apt/sources.list.d/openhab.list</code><code v-else-if="selectedVersion === 'testing'">echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg testing main' | sudo tee /etc/apt/sources.list.d/openhab.list</code><code v-else>echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg unstable main' | sudo tee /etc/apt/sources.list.d/openhab.list</code></pre>
          </div>
        </li>
        <li>
          Update the package lists and install the openHAB distribution package
          <div class="language-shell">
            <pre class="language-shell"><code>sudo apt-get update &amp;&amp; sudo apt-get install openhab</code></pre>
          </div>
        </li>
        <li>
          <strong>(Optional)</strong> Install the add-ons for offline use<br />
          &#128712; <small>You don't need the add-ons package if your machine has Internet access, openHAB will download add-ons online as necessary.</small>
          <div class="language-shell">
            <pre class="language-shell"><code>sudo apt-get install openhab-addons</code></pre>
          </div>
        </li>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>
          Continue by following the <a :href="withBase('/docs/tutorial/')">tutorial</a> to get started
        </li>
      </ol>
    </div>

    <!-- Linux RPM -->
    <div v-if="selectedSystem === 'tux' && selectedDistro === 'rpm'">
      <hr />
      <h3>{{ optionNumber('package') }}Install the RPM Packages (Recommended)</h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction"></li>
        <li>
          Create a new <code>/etc/yum.repos.d/openhab.repo</code> file with the following content:
          <div class="language-ini">
            <pre class="language-ini"><code>[openHAB-{{ selectedVersion === 'stable' ? 'Stable' : selectedVersion === 'testing' ? 'Testing' : 'Snapshots' }}]
name=openHAB {{ selectedVersion === 'stable' ? 'Stable' : selectedVersion === 'testing' ? 'Testing' : 'Snapshots' }}
baseurl={{ selectedVersion === 'stable' ? 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/stable' : selectedVersion === 'testing' ? 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/testing' : 'https://openhab.jfrog.io/artifactory/openhab-linuxpkg-rpm/unstable' }}
gpgcheck=1
gpgkey=https://openhab.jfrog.io/artifactory/api/gpg/key/public
enabled=1
</code></pre>
          </div>
        </li>
        <li>
          Install the openHAB distribution package
          <div class="language-shell">
            <pre class="language-shell"><code>sudo yum install openhab</code></pre>
          </div>
        </li>
        <li>
          <strong>(Optional)</strong> Install the add-ons for offline use<br />
          &#128712; <small>You don't need the add-ons package if your machine has Internet access, openHAB will download add-ons online as necessary.</small>
          <div class="language-shell">
            <pre class="language-shell"><code>sudo yum install openhab-addons</code></pre>
          </div>
        </li>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>
          Continue by following the <a :href="withBase('/docs/tutorial/')">tutorial</a> to get started
        </li>
      </ol>
    </div>

    <!-- Docker -->
    <div v-if="selectedSystem === 'docker'">
      <hr />
      <h3>Docker Container Quick Installation</h3>
      <p>
        These are very simplified instructions, check the
        <a :href="withBase('/docs/installation/docker.html')">documentation article</a> or
        <a target="_blank" href="https://hub.docker.com/r/openhab/openhab/" rel="noopener noreferrer">
          https://hub.docker.com/r/openhab/openhab/
        </a>
        for more information.
      </p>
      <ol>
        <li>
          Create the <code>openhab</code> user:
          <div class="language-shell">
            <pre class="language-shell"><code>groupadd -g 9001 openhab
useradd -g 9001 openhab
usermod -a -G openhab myownuser
</code></pre>
          </div>
        </li>
        <li>
          Pull and run the container (command line version):
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
        openhab/openhab:{{ selectedVersion === 'stable' ? frontmatter.currentVersion : selectedVersion === 'testing' ? frontmatter.currentMilestoneVersion : (frontmatter.currentSnapshotVersion || '').toLowerCase() }}
</code></pre>
          </div>
        </li>
        <li>
          <strong>(Optional)</strong> Download the add-on archives for offline use:<br />
          &#128712; <small>You don't need the add-ons archives if your machine has Internet access.</small>
          <div v-if="selectedVersion === 'stable' || selectedVersion === 'testing'">
            <div class="download-button-container">
              <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>
                Download openHAB {{ currentDownloadVersion }} {{ currentVersionLabel }} Add-ons
              </a>
            </div>
          </div>
          <div v-if="selectedVersion === 'snapshot'">
            <div class="download-button-container">
              <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>
                Download openHAB {{ frontmatter.currentSnapshotVersion }} Add-ons
              </a>
            </div>
          </div>
        </li>
      </ol>
    </div>

    <!-- MacOS Homebrew -->
    <div v-if="selectedSystem === 'apple' && selectedVersion !== 'snapshot'">
      <hr />
      <h3>{{ optionNumber('package') }}Install the Homebrew Package (Recommended)</h3>
      <ol>
        <li>Install the <a target="_blank" href="https://brew.sh" rel="noopener noreferrer">Homebrew</a> package manager</li>
        <li>
          Add the
          <a target="_blank" href="https://github.com/openhab/homebrew-openhab" rel="noopener noreferrer">
            openHAB Homebrew tap
          </a>
          <div class="language-shell">
            <pre class="language-shell"><code>brew tap openhab/openhab</code></pre>
          </div>
        </li>
        <li>
          Install the openHAB package<br />
          &#128712; <small>This will automatically install the <code>openjdk@21</code> package.</small>
          <div class="language-shell">
            <pre class="language-shell"><code>brew install {{ homebrewPackageName }}</code></pre>
          </div>
        </li>
        <li>
          Pin both the openHAB &amp; Java package versions<br />
          &#128712; <small>This prevents Homebrew from upgrading those packages when running</small>
          <div class="language-shell">
            <pre class="language-shell"><code>brew pin openjdk@21 {{ homebrewPackageName }}</code></pre>
          </div>
        </li>
        <li>
          <strong>(Optional)</strong> Install the add-ons for offline use<br />
          &#128712; <small>Type <code>brew info {{ homebrewPackageName }}</code> for instructions.</small>
        </li>
        <li>
          Start openHAB as a service
          <div class="language-shell">
            <pre class="language-shell"><code>brew services start {{ homebrewPackageName }}</code></pre>
          </div>
        </li>
        <li>Navigate with a web browser to <code>http://&lt;ip-address&gt;:8080</code></li>
        <li>
          Continue by following the <a :href="withBase('/docs/tutorial/')">tutorial</a> to get started
        </li>
      </ol>
      <p>
        More detailed installation instructions can be found in the
        <a target="_blank" :href="withBase('/docs/installation/macos.html')">macOS Installation Docs</a>.
      </p>
    </div>

    <!-- Manual installation -->
    <div v-if="selectedSystem !== 'docker'">
      <hr />
      <h3>{{ optionNumber('manual') }}Manual Installation</h3>
      <div class="warning custom-block">
        <p class="custom-block-title">REMINDER</p>
        <p>openHAB 5 requires Java 21!</p>
      </div>
      <ol>
        <li v-html="javaDownloadInstruction"></li>
        <li>
          Download and extract the openHAB runtime distribution:
          <div class="download-button-container">
            <a class="download-button big" :href="runtimeDownloadLink" download>
              Download openHAB {{ currentDownloadVersion }} {{ currentVersionLabel }} Runtime
            </a>
          </div>
        </li>
        <li>
          <strong>(Optional)</strong> Download the add-on archives for offline use:<br />
          &#128712; <small>You don't need the add-ons archives if your machine has Internet access.</small>
          <div class="download-button-container">
            <a class="download-button" style="margin-bottom: 0" :href="addonsDownloadLink" download>
              Download openHAB {{ currentDownloadVersion }} {{ currentVersionLabel }} Add-ons
            </a>
          </div>
        </li>
        <li v-if="selectedSystem === 'apple'">
          Open <em>System Preferences &gt; Keyboard &gt; Shortcuts</em> and check the <em>New Terminal at Folder</em> option under <em>Services</em>:<br />
          <img class="img-center" :src="withBase('/components/images/macos-settings.png')" alt="" />
        </li>
        <li v-if="selectedSystem === 'apple'">
          Using the Finder, find the folder with the extracted runtime, open its context menu and select <em>New Terminal at Folder</em>:<br /><br />
          <img class="img-center" :src="withBase('/components/images/macos-contextmenu.png')" alt="" /><br />
        </li>
        <li>
          <span v-if="selectedSystem !== 'win10'">Run <code>./start.sh</code></span>
          <span v-else>Run <code>start.bat</code></span>
          <span v-if="selectedSystem === 'apple'"> in the Terminal</span>
          and wait for openHAB to perform its initial startup (this can take a few minutes)
        </li>
        <li>
          Navigate with a web browser to
          <code>http://{{ selectedSystem === 'apple' || selectedSystem === 'win10' ? 'localhost' : '&lt;ip-address&gt;' }}:8080</code>
        </li>
        <li>
          Continue by following the <a :href="withBase('/docs/tutorial/')">tutorial</a> to get started
        </li>
      </ol>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useData, withBase } from 'vitepress'

const { frontmatter } = useData()

const systems = [
  ['raspberry-pi', 'Raspberry Pi'],
  ['tux', 'Linux'],
  ['win10', 'Windows'],
  ['apple', 'macOS'],
  ['docker', 'Docker'],
]

const selectedSystem = ref('raspberry-pi')
const selectedDistro = ref('deb')
const selectedVersion = ref('stable')

function selectSystem(system: string) {
  selectedSystem.value = system
}

function selectVersion(version: string) {
  selectedVersion.value = version
}

function selectDistro(distro: string) {
  selectedDistro.value = distro
}

function optionNumber(type: string) {
  if (type === 'openhabian') return 'Option 1: '
  if (type === 'package' && selectedSystem.value === 'tux') return 'Option 1: '
  if (type === 'package' && selectedSystem.value === 'raspberry-pi') return 'Option 2: '
  if (type === 'package' && selectedSystem.value === 'apple') return 'Option 1: '
  if (type === 'manual' && selectedSystem.value === 'tux') return 'Option 2: '
  if (type === 'manual' && selectedSystem.value === 'raspberry-pi') return 'Option 3: '
  if (type === 'manual' && selectedSystem.value === 'apple') return selectedVersion.value === 'snapshot' ? '' : 'Option 2: '
  return ''
}

const versions = computed(() => {
  const ret = [['stable', 'Stable']]
  if (frontmatter.value.currentMilestoneVersion) ret.push(['testing', 'Milestone'])
  ret.push(['snapshot', 'Snapshot'])
  return ret
})

const runtimeDownloadLink = computed(() => {
  if (selectedVersion.value === 'stable') {
    return `https://github.com/openhab/openhab-distro/releases/download/${frontmatter.value.currentVersion}/openhab-${frontmatter.value.currentVersion}.zip`
  } else if (selectedVersion.value === 'testing') {
    return `https://github.com/openhab/openhab-distro/releases/download/${frontmatter.value.currentMilestoneVersion}/openhab-${frontmatter.value.currentMilestoneVersion}.zip`
  } else {
    return `https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab/target/openhab-${frontmatter.value.currentSnapshotVersion}.zip`
  }
})

const addonsDownloadLink = computed(() => {
  if (selectedVersion.value === 'stable') {
    return `https://github.com/openhab/openhab-distro/releases/download/${frontmatter.value.currentVersion}/openhab-addons-${frontmatter.value.currentVersion}.kar`
  } else if (selectedVersion.value === 'testing') {
    return `https://github.com/openhab/openhab-distro/releases/download/${frontmatter.value.currentMilestoneVersion}/openhab-addons-${frontmatter.value.currentMilestoneVersion}.kar`
  } else {
    return `https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons/target/openhab-addons-${frontmatter.value.currentSnapshotVersion}.kar`
  }
})

const currentDownloadVersion = computed(() => {
  if (selectedVersion.value === 'stable') {
    return frontmatter.value.currentVersion
  } else if (selectedVersion.value === 'testing') {
    return frontmatter.value.currentMilestoneVersion
  } else {
    return frontmatter.value.currentSnapshotVersion
  }
})

const currentVersionLabel = computed(() => {
  if (selectedVersion.value) {
    const found = versions.value.find((v) => v[0] === selectedVersion.value)
    return found ? found[1] : ''
  }
  return ''
})

const javaDownloadInstruction = computed(() => {
  return `Install a recent Java 21 platform (we recommend your OS package repository provided OpenJDK build, or the <a target="_blank" href="https://adoptium.net/temurin/releases/?version=21&package=jre" rel="noopener noreferrer">Eclipse Adoptium Temurin</a> builds of OpenJDK)`
})

const homebrewPackageName = computed(() => {
  if (selectedVersion.value === 'stable') return 'openhab'
  return 'openhab-milestone'
})
</script>

<style scoped>
.instructions {
  margin-top: 1rem;
  margin-bottom: 0.3rem;
  font-size: 1.5rem;
  font-weight: 400;
  text-align: center;
  font-family: 'Open Sans', sans-serif;
}
.os-tabs {
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 8px;
}
.os-tabs .os-tab {
  width: 17%;
  padding: 8px 3px;
  text-align: center;
  position: relative;
  border: 2px solid transparent;
  border-radius: 6px;
  cursor: pointer;
  background: var(--vp-c-bg-elv, #fafafa);
  transition: all 0.2s;
}
.os-tabs .os-tab:hover {
  background: var(--vp-c-bg-alt, #f0f0f0);
}
.os-tabs .os-tab.selected {
  border: 2px solid var(--vp-c-brand-1, #ff6600);
}
.os-tabs .os-tab img {
  height: 48px;
  display: block;
  margin: 0 auto;
  object-fit: contain;
}
.os-tabs .os-tab .os-label {
  margin-top: 8px;
  font-size: 12px;
}
.distro-tabs {
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 12px;
  margin-top: 0.5rem;
}
.distro-tabs .distro-tab {
  width: 30%;
  padding: 8px;
  text-align: center;
  border: 2px solid transparent;
  border-radius: 6px;
  cursor: pointer;
  font-size: 15px;
  background: var(--vp-c-bg-elv, #fafafa);
}
.distro-tabs .distro-tab img {
  height: 24px;
  display: inline-block;
  margin: 0 2px;
}
.distro-tabs .distro-tab:hover {
  background: var(--vp-c-bg-alt, #f0f0f0);
}
.distro-tabs .distro-tab.selected {
  border: 2px solid var(--vp-c-brand-1, #ff6600);
}
.version-tabs {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: stretch;
  gap: 12px;
  margin-top: 0.5rem;
}
.version-tabs .version-tab {
  width: 20%;
  min-width: 120px;
  min-height: 48px;
  padding: 6px 10px;
  text-align: center;
  border: 2px solid transparent;
  border-radius: 6px;
  cursor: pointer;
  background: var(--vp-c-bg-elv, #fafafa);
  transition: all 0.2s;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  box-sizing: border-box;
}
.version-tabs .version-tab strong {
  display: block;
  font-size: 14px;
  font-weight: 600;
  line-height: 1.2;
  margin: 0 !important;
  padding: 0 !important;
}
.version-tabs .version-tab small {
  display: block;
  font-size: 11px;
  color: var(--vp-c-text-2, #666);
  margin: 2px 0 0 0 !important;
  line-height: 1.2;
  padding: 0 !important;
}
.version-tabs .version-tab:hover {
  background: var(--vp-c-bg-alt, #f0f0f0);
}
.version-tabs .version-tab.selected {
  border: 2px solid var(--vp-c-brand-1, #ff6600);
}
.version-explanation {
  padding: 8px;
  margin: 1rem 0;
  text-align: center;
  font-size: 14px;
}
.download-button-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin: 1.5rem 0;
}
.download-button {
  display: inline-block;
  font-family: 'Open Sans', sans-serif;
  font-size: 0.9rem;
  color: var(--vp-c-brand-1, #ff6600);
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  font-weight: bold;
  box-sizing: border-box;
  border: 2px solid var(--vp-c-brand-1, #ff6600);
  text-decoration: none;
  transition: all 0.2s;
}
.download-button.big {
  font-size: 1.2rem;
}
.download-button:hover {
  background-color: var(--vp-c-brand-1, #ff6600);
  color: white;
  text-decoration: none !important;
}
.img-center {
  display: block;
  margin: 1rem auto;
  max-width: 75%;
}
@media (max-width: 480px) {
  .os-tabs {
    flex-wrap: wrap;
  }
  .os-tabs .os-tab {
    width: 30%;
  }
  .distro-tabs .distro-tab {
    width: 48%;
  }
  .version-tabs .version-tab {
    width: 30%;
  }
}
</style>
