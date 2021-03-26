<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonAdmin for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Admin\Controller;

use Admin\Form\ContactFormForm;
use Laminas\Mvc\Controller\AbstractActionController;
use Laminas\View\Model\ViewModel;

class AdminController extends AbstractActionController
{
        protected $entityManager;
        protected $serviceManager;

        public function __construct($entityManager,$serviceManager) 
        {
        $this->entityManager = $entityManager;
        $this->serviceManager = $serviceManager;
        }

        public function indexAction()
        {
                $slides = $this->entityManager->getRepository(\Admin\Entity\Slides::class)->findBy([],['slidesId'=>'asc']);
                return new ViewModel(
                        [
                                'slides' => $slides,
                        ]
                );
        }

        public function nousConnaitreAction()
        {
                //die("[ellow]"); 
        }
        public function prestationsServiceAction()
        {
            //Nous récuperons les service ici
            $services = $this->entityManager->getRepository(\Admin\Entity\Service::class)->findBy([],['prestationServiceId'=>'asc']);
            //Tableau contenant les services, sections par services y compris
            $tabServices = [];
            //Pour chaque service nous recuperons les sections
            foreach($services as $service)
            {
                $sections = $this->entityManager->getRepository(\Admin\Entity\Section::class)->findBy(['prestationServiceId'=> $service->getServiceId()]);
                $tab = [
                    'prestationServiceId' =>  $service->getServiceId(),
                    'libelle' =>  $service->getLibelle(),
                    'image' =>  $service->getImage(),
                    'sections' =>  $sections,
                ];
                array_push($tabServices, $tab);
            }
            //var_dump($tabServices);
            //die();
            return new ViewModel([
                'prestationsServices' => $tabServices,
            ]);
        }

        public function contactFormAction()
        {       
                //Si le formulaire n'a pas été posté,
                $form = new ContactFormForm();
                if(!$this->getRequest()->isPost()){
            
                        return new ViewModel([
                            'form' => $form
                        ]);
                    }

                // Si on click sur le bouton envoyer(post du formulaire)
                if($this->getRequest()->isPost() && $this->getRequest()->getPost('envoyer'))
                {
                        $datas = $this->params()->fromPost();
                        $form->setData($datas);
                        if(!$form->isValid()){
                                return new ViewModel([
                                        'form' => $form   
                        ]);
                        }
                        $datas = $form->getData();
                        //enregister les données dans la bd, envoyer le mail sur le compte du gestionnaire,
                        $this->serviceManager->envoieContactForm($datas);
                        //afficher le message succès.

                        $message = 'Votre demande a bien été envoyer à GR - Consult';
                        $this->flashMessenger()->addSuccessMessage($message);

                        return $this->redirect()->toRoute('contact', 
                                [
                                'action'=>'modifier',
                                ]); 
                }
        }
        public function contactAction()
        {
                //Si le formulaire n'a pas été posté,
                $form = new ContactFormForm();
                $tabContacts=[];
                $contacts = $this->entityManager->getRepository(\Admin\Entity\Contact::class)->findBy([]);
                foreach($contacts as $contact)
                {
                        $adresse = $this->entityManager->getRepository(\Admin\Entity\ContactLocalisatonAdresse::class)->find($contact->getContactLocalisatonAdresseId());
                        //var_dump($adresse); die();
                        $tab = [
                        'email' =>  $contact->getEmail(),
                        'Telephone' =>  $contact->getTelephone() .' / '.$contact->getFixe() ,
                        'Horaires' =>  $contact->getHoraires(),
                        'adresse' =>  $adresse->getDescription(),
                        
                        ];
                        array_push($tabContacts, $tab);
                }
                $infosContacts =$tabContacts;
                if(!$this->getRequest()->isPost()){
            
                        return new ViewModel([
                            'form' => $form,
                            'infosContacts' => $infosContacts,
                        ]);
                    }

                // Si on click sur le bouton envoyer(post du formulaire)
                if($this->getRequest()->isPost() && $this->getRequest()->getPost('envoyer'))
                {
                        $datas = $this->params()->fromPost();
                        $form->setData($datas);
                       
                        if(!$form->isValid()){
                                return new ViewModel([
                                        'form' => $form,
                                        'infosContacts' => $infosContacts,   
                                ]);
                        }
                        $donneesValidees = $form->getData();
                        //var_dump($datas);
                        //die();
                        //enregister les données dans la bd, envoyer le mail sur le compte du gestionnaire,
                        $this->serviceManager->envoieContactForm($datas);
                        //afficher le message succès.

                        $message = 'Votre demande a bien été envoyer à GR - Consult';
                        $this->flashMessenger()->addSuccessMessage($message);

                        return $this->redirect()->toRoute('contact'); 
                }




                //die("[ellow]"); 
                /*

                $infosContact = [
                        'email' =>  'infos@grconsult.ci',    
                        'Telephone' =>  '(+225) 22015889 / 0595407894 ',    
                        'Horaires' =>  'Ouvert Du Lundi au vendredi: 8h-18h',    
                ];
                return new ViewModel([
                        'infosContact' => $infosContact,
                ]);

                */
        }
        public function galerieAction()
        {
                //die("[ellow]"); 
        }

        public function formationsAction()
        {
              //Nous récuperons les formations ici
            $formations = $this->entityManager->getRepository(\Admin\Entity\Formation::class)->findBy([],['libelle'=>'asc']);
            //Tableau contenant les services, sections par services y compris
            $tabFormations = [];
            //Pour chaque service nous recuperons les sections
            foreach($formations as $formation)
            {
                $module = $this->entityManager->getRepository(\Admin\Entity\Module::class)->findOneBy(['formationId'=> $formation->getFormationId()]);
                $type = $this->entityManager->getRepository(\Admin\Entity\TypeFormation::class)->find($formation->getTypeFormationId());
                $conditions = $this->entityManager->getRepository(\Admin\Entity\ConditionParticipation::class)->findOneBy(['formationId'=> $formation->getFormationId()]);
                $tab = [
                    'formationId' =>  $formations->getServiceId(),
                    'libelle' =>  $formations->getLibelle(),
                    'dateDebut' =>  $formations->getDateDebut(),
                    'dateFin' =>  $formations->getDateFin(),
                    'lieu' =>  $formations->getLieu(),
                    'dateCreation' =>  $formations->getDateCreation(),
                    'typeFormationId' =>  $formations->getTypeFormationId(),
                    'typeLibelle' =>  $type->getLibelle(),
                    'modules' =>  $module,
                    'conditions' =>  $conditions,
                ];
                array_push($tabFormations, $tab);
            }
            //var_dump($tabServices);
            //die();
            return new ViewModel([
                'formations' => $tabFormations,
            ]);
        }

}