<script setup>
const title = usePageTitle("Accueil")
</script>

<template>
    <div class="row">
  <div class="col-12 col-md-6">
    <h1>
      <span aria-hidden="true">🎯</span>
      <span aria-hidden="true">Votre expert en développement Web</span>
      <span class="visually-hidden">Votre expert en développement web</span>
    </h1>
    <div>
      <strong>Michel Auclert - Consultant Web &amp; Accessibilité</strong>
    </div>
    <div>
      Développeur senior spécialisé en Angular et accessibilité numérique, je
      conçois des sites web performants, inclusifs et évolutifs.
    </div>
    <div>
      <span aria-hidden="true">📍</span> Basé à Perpignan, France – Disponible en
      télétravail ou au forfait
    </div>

    <div class="mt-3">
      <a href="/prestations-web">Prestations Web</a>
    </div>
    <ul class="list-ok">
      <li>Développement front-end sur mesure</li>
      <li>Création de sites internet</li>
      <li>Audit accessibilité et mise en conformité WCAG</li>
      <li>Formation-action WordPress</li>
    </ul>
    <div class="d-flex align-items-center gap-2 mt-4">
      <div>
        <img :src="'/images/Michel_auclert-contact.png'" alt="Contact" />

      </div>
      <div>
        <a href="/contact">Contactez-moi pour discuter de votre projet. </a>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4 alert alert-success mt-4 mt-md-0">
    <h2>Vous êtes concerné par l'accessibilité numérique ?</h2>
    Merci de prendre quelques minutes pour tester l’accessibilité de mon site. Votre
    retour m’aide à améliorer l’expérience pour tous, et en particulier pour les personnes
    utilisant un lecteur d’écran.

    <br />Le questionnaire est très court (3 à 5 minutes). Aucune donnée
    personnelle n’est collectée. Pour ce faire, veuillez naviguer sur le site,
    notamment sur les pages "Prestations Web", "Contact", "Déclaration
    Accessibilité ", puis <a
      href="https://docs.google.com/forms/d/e/1FAIpQLSe9tfsQA2_8iS4f0Z18npNjoGFnrLLd0p4fcil9NSG7Bt_TUw/viewform?fbzx=2386291683972395792"
      target="_blank"
      rel="noopener noreferrer"
      >donner votre feed-back via le formulaire dédié</a
    >.
    <br />
    <p>
      <strong
        >❤️ Un grand merci d'avance pour votre contribution précieuse !</strong
      >
    </p>
  </div>
</div>

</template>
