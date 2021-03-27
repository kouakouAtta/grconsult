<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonAdmin for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Admin;

use Zend\Router\Http\Literal;
use Zend\Router\Http\Segment;
//use Zend\Router\Http\Regex;
use Doctrine\ORM\Mapping\Driver\AnnotationDriver;
use Zend\ServiceManager\Factory\InvokableFactory;

return [
    'router' => [
        'routes' => [
            'admin.home' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'index',
                    ],
                ],
            ],
            'admin' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/admin[/:action]',
                    'defaults' => [
                        'controller'    => Controller\AdminController::class,
                        'action'        => 'index',
                    ],
                ],
            ],
            'nousConnaitre' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/nous-connaitre',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'nousConnaitre',
                    ],
                ],
            ],
             'prestationsService' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/prestations-service',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'prestationsService',
                    ],
                ],
            ],
            'voir-section' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/voir-section[/:action[/:id]]',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'voirSection',
                    ],
                ],
            ],
            'contact' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/contact',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'contact',
                    ],
                ],
            ],
            'contactForm' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/contact-form',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'contactForm',
                    ],
                ],
            ],
             'galerie' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/galerie',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'galerie',
                    ],
                ],
            ],
            'contactForm' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/contact-form',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'contactForm',
                    ],
                ],
            ],
            'formations' => [
                'type' => Segment::class,
                'options' => [
                    'route'    => '/formations',
                    'defaults' => [
                        'controller' => Controller\AdminController::class,
                        'action'     => 'formations',
                    ],
                ],
            ],
            
//            'download' => [
//                'type'    => Segment::class,
//                'options' => [
//                    'route'    => '/download[/:action]',
//                    'defaults' => [
//                        'controller'    => Controller\DownloadController::class,
//                        'action'        => 'index',
//                    ],
//                ],
//            ],
//            'static' => [
//                'type' => StaticRoute::class,
//                'options' => [
//                    'dir_name'         => __DIR__ . '/../view',
//                    'template_prefix'  => 'Admin/index/static',
//                    'filename_pattern' => '/[a-z0-9_\-]+/',
//                    'defaults' => [
//                        'controller' => Controller\IndexController::class,
//                        'action'     => 'static',
//                    ],                    
//                ],
//            ],          
        ],
    ],
    'controllers' => [
        'factories' => [
            //Controller\IndexController::class => InvokableFactory::class,
            Controller\AdminController ::class => Controller\Factory\AdminControllerFactory::class,
        ],
    ],
    // The following registers our custom view 
    // helper classes in view plugin manager.
    'view_helpers' => [
//        'factories' => [
//            View\Helper\Menu::class => InvokableFactory::class,
//            View\Helper\Breadcrumbs::class => InvokableFactory::class,
//        ],
//        'aliases' => [
//            'mainMenu' => View\Helper\Menu::class,
//            'pageBreadcrumbs' => View\Helper\Breadcrumbs::class,
//        ],
    ],

    'service_manager' => [
        'factories' => [
            
            Service\ServiceManager::class => Service\Factory\ServiceManagerFactory::class,
            
            //Service\BordereauManager ::class => Service\Factory\BordereauManagerFactory::class,
        ],
    ],

    // The following key allows to define custom styling for FlashMessenger view helper.
    'view_helper_config' => [
        'flashmessenger' => [
            'message_open_format'      => '<div%s><button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                          </button>',
            'message_close_string'     => '</div>',
            'message_separator_string' => ''
        ]
    ],  

    'doctrine' => [
        'driver' => [
            __NAMESPACE__ . '_driver' => [
                'class' => AnnotationDriver::class,
                'cache' => 'array',
                'paths' => [__DIR__ . '/../src/Entity']
            ],
            'orm_default' => [
                'drivers' => [
                    __NAMESPACE__ . '\Entity' => __NAMESPACE__ . '_driver'
                ]
            ]
        ]
    ],

    'view_manager' => [
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => [
            'layout/admin'           => __DIR__ . '/../view/layout/admin.phtml',
            'admin/index/index' => __DIR__ . '/../view/admin/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ],
        'template_path_stack' => [
            __DIR__ . '/../view',
        ],
        // The following is needed to be able to return JSON response from controller actions.
        'strategies' => [
            'ViewJsonStrategy',
        ],
    ],
];
