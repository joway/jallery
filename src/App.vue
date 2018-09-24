<template>
  <div id="app" class="row">
    <div class="col-xs">
      <router-view/>
    </div>
  </div>
</template>
<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import 'flexboxgrid/dist/flexboxgrid.min.css'

@Component({
  components: {},
})
export default class App extends Vue {}
</script>
<style>
body {
  margin: 0;
  font-family: 'Karla', sans-serif;
}
a {
  text-decoration: none;
  color: #000;
}
</style>
